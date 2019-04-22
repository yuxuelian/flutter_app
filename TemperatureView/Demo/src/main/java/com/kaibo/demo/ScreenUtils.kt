package com.kaibo.demo

import android.app.Activity
import android.graphics.Color
import android.os.Build
import android.view.View
import android.view.Window
import android.view.WindowManager
import androidx.fragment.app.Fragment

/**
 * @author:Administrator
 * @date:2018/4/8 0008 下午 12:52
 * GitHub:
 * email:
 * description:对android屏幕尺寸等相关操作的扩展方法
 */

/**
 * 状态栏高
 */
private val _statusBarHeight: Int by lazy {
    AppContext.resources.let {
        it.getDimensionPixelSize(it.getIdentifier("status_bar_height", "dimen", "android"))
    }
}

/**
 * 导航栏高度
 */
private val _navigationBarHeight: Int by lazy {
    AppContext.resources.let {
        it.getDimensionPixelSize(it.getIdentifier("navigation_bar_height", "dimen", "android"))
    }
}

/**
 * 设备宽
 */
private val _deviceWidth by lazy {
    AppContext.resources.displayMetrics.widthPixels
}

/**
 * 设备高
 */
private val _deviceHeight by lazy {
    AppContext.resources.displayMetrics.heightPixels
}

/**
 * 状态栏的高度
 */
val Activity.statusBarHeight
    get() = _statusBarHeight
val Activity.navigationBarHeight
    get() = _navigationBarHeight
val Fragment.statusBarHeight
    get() = _statusBarHeight
val View.statusBarHeight
    get() = _statusBarHeight

/**
 * 屏幕的宽高
 */
val Activity.deviceWidth
    get() = _deviceWidth

val Activity.deviceHeight
    get() = _deviceHeight

val Fragment.deviceWidth
    get() = _deviceWidth

val Fragment.deviceHeight
    get() = _deviceHeight

val View.deviceWidth
    get() = _deviceWidth

val View.deviceHeight
    get() = _deviceHeight

/**
 * 设置沉浸式
 * isLight是否对状态栏颜色变黑
 */
fun Window.immersive(isLight: Boolean) {
    when {
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP -> {
            clearFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS or WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)
            addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
            //SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN 布局设置为全屏布局
            //SYSTEM_UI_FLAG_LAYOUT_STABLE
            //SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
            decorView.systemUiVisibility = View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN or
                    View.SYSTEM_UI_FLAG_LAYOUT_STABLE or
                    if (isLight && Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
                    } else {
                        0
                    }
            statusBarColor = Color.TRANSPARENT
        }
        Build.VERSION.SDK_INT >= Build.VERSION_CODES.KITKAT -> {
            addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_STATUS)
//            decorView.setPadding(0, 0, 0, _navigationBarHeight)
//            decorView.setBackgroundColor(Color.BLACK)
        }
        else -> {
            return
        }
    }
}

fun Window.showMenuKey() {
    if (Build.VERSION.SDK_INT <= Build.VERSION_CODES.LOLLIPOP) {
        addFlags(WindowManager.LayoutParams::class.java.getField("FLAG_NEEDS_MENU_KEY").getInt(null))
    } else {
        val setNeedsMenuKey = Window::class.java.getDeclaredMethod("setNeedsMenuKey", Int::class.javaPrimitiveType)
        val value = WindowManager.LayoutParams::class.java.getField("NEEDS_MENU_SET_TRUE").getInt(null)
        setNeedsMenuKey.isAccessible = true
        setNeedsMenuKey.invoke(this, value)
    }
}

/**
 * 设置标题栏字体颜色
 */
fun Activity.setLightStatusBar(isLight: Boolean) {
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
        if (isLight) {
            window.decorView.systemUiVisibility =
                window.decorView.systemUiVisibility or View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR
        } else {
            window.decorView.systemUiVisibility =
                window.decorView.systemUiVisibility and (View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR.inv())
        }
    }
}

/**
 * ImageView使用Glide进行图片加载
 */
//fun ImageView.defaultLoadImage(url: String?) {
//    GlideApp
//            .with(context)
//            .load(url)
//            .diskCacheStrategy(DiskCacheStrategy.ALL)
//            .centerCrop()
//            .placeholder(R.drawable.ic_image_loading)
//            .error(R.drawable.ic_empty_picture)
//            .into(this)
//}
//
//fun ImageView.displayHigh(url: String?) {
//    GlideApp
//            .with(context)
//            .asBitmap()
//            .load(url)
//            .format(DecodeFormat.PREFER_ARGB_8888)
//            .diskCacheStrategy(DiskCacheStrategy.ALL)
//            .centerCrop()
//            .placeholder(R.drawable.ic_image_loading)
//            .error(R.drawable.ic_empty_picture)
//            .into(this)
//}