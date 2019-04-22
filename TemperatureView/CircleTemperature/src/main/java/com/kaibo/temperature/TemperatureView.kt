package com.kaibo.temperature

import android.content.Context
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.PointF
import android.util.AttributeSet
import android.util.Log
import androidx.appcompat.widget.AppCompatImageView

/**
 * @author kaibo
 * @date 2019/4/18 17:45
 * @GitHub：https://github.com/yuxuelian
 * @email：kaibo1hao@gmail.com
 * @description：
 */

class TemperatureView @JvmOverloads constructor(
    context: Context,
    attrs: AttributeSet? = null,
    defStyle: Int = 0
) : AppCompatImageView(context, attrs, defStyle) {

    companion object {
        private val MAX_DEGREES_RANGE = Pair(0, 300)
        private val MAX_TEMPERATURE_RANGE = Pair(-50, 50)

        // 开口角度
        private const val EMPTY_DEGREES = 60
    }

    var circleRadius: Int = dimen(R.dimen.default_circle_radius)
        set(value) {
            field = value
            invalidate()
        }

    var lineLength: Int = dimen(R.dimen.default_line_length)
        set(value) {
            field = value
            invalidate()
        }

    var padding: Int = dimen(R.dimen.default_padding)
        set(value) {
            field = value
            invalidate()
        }

    var lineWidth: Int = dimen(R.dimen.default_line_width)
        set(value) {
            field = value
            mPaint.strokeWidth = value.toFloat()
            invalidate()
        }

    var lineColor: Int = color(R.color.default_line_color)
        set(value) {
            field = value
            mPaint.color = value
            invalidate()
        }

    // 温度范围
    var temperatureRange = Pair(10, 30)
        set(value) {
            field = value
            invalidate()
        }

    var minTemperatureColor = color(R.color.min_temperature_color)
    var maxTemperatureColor = color(R.color.max_temperature_color)

    private val computeDegreesRange: Pair<Int, Int>
        get() = Pair(
            temperatureRange.first * 3 + 150,
            temperatureRange.second * 3 + 150
        )

    private fun Pair<Int, Int>.container(target: Int): Boolean {
        return target in first..second
    }

    private fun computeColor(rate: Float): Int {
        Log.d("TemperatureView", "computeColor rate =$rate")
        val minAlpha = Color.alpha(minTemperatureColor)
        val minRed = Color.red(minTemperatureColor)
        val minGreen = Color.green(minTemperatureColor)
        val minBlue = Color.blue(minTemperatureColor)
        val maxAlpha = Color.alpha(maxTemperatureColor)
        val maxRed = Color.red(maxTemperatureColor)
        val maxGreen = Color.green(maxTemperatureColor)
        val maxBlue = Color.blue(maxTemperatureColor)
        return Color.argb(
            (minAlpha + (maxAlpha - minAlpha) * rate).toInt(),
            (minRed + (maxRed - minRed) * rate).toInt(),
            (minGreen + (maxGreen - minGreen) * rate).toInt(),
            (minBlue + (maxBlue - minBlue) * rate).toInt()
        )
    }

    private val mPaint = Paint().apply {
        style = Paint.Style.STROKE
        isAntiAlias = true
        strokeWidth = lineWidth.toFloat()
        color = lineColor
        strokeCap = Paint.Cap.ROUND
    }

    private var mCenterPoint = PointF(0f, 0f)

    override fun onMeasure(widthMeasureSpec: Int, heightMeasureSpec: Int) {
        super.onMeasure(widthMeasureSpec, heightMeasureSpec)
    }

    override fun onSizeChanged(w: Int, h: Int, oldw: Int, oldh: Int) {
        mCenterPoint = PointF(w / 2f, h / 2f)
    }

    override fun onDraw(canvas: Canvas) {
//        canvas.save()
//        canvas.rotate((90 + EMPTY_DEGREES / 2.0).toFloat(), mCenterPoint.x, mCenterPoint.y)
//        val oval = RectF(
//            mCenterPoint.x - circleRadius,
//            mCenterPoint.y - circleRadius,
//            mCenterPoint.x + circleRadius,
//            mCenterPoint.y + circleRadius
//        )
//        canvas.drawArc(
//            oval,
//            0f,
//            300f,
//            false,
//            mPaint
//        )
//        canvas.restore()

        canvas.rotate((180 + EMPTY_DEGREES / 2.0).toFloat(), mCenterPoint.x, mCenterPoint.y)
        repeat(101) {
            val rotateDegrees = (it * 3).toFloat()
            canvas.save()
            canvas.rotate(rotateDegrees, mCenterPoint.x, mCenterPoint.y)

            if (computeDegreesRange.container(rotateDegrees.toInt())) {
                mPaint.color = computeColor(rotateDegrees / 300)
            } else {
                mPaint.color = lineColor
            }

            Log.d(
                "TemperatureView",
                "computeColor(rotateDegrees / 300) =${String.format("%x", computeColor(rotateDegrees / 300))}"
            )

            when (it) {
                0, 100 -> {
                    canvas.drawLine(
                        mCenterPoint.x,
                        0f,
                        mCenterPoint.x,
                        (lineLength + padding).toFloat(),
                        mPaint
                    )
                }
                else -> {
                    canvas.drawLine(
                        mCenterPoint.x,
                        padding.toFloat(),
                        mCenterPoint.x,
                        (lineLength + padding).toFloat(),
                        mPaint
                    )
                }
            }
            canvas.restore()
        }
    }

}
