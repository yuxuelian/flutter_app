package com.kaibo.temperature

import android.content.Context
import android.view.View
import androidx.annotation.ColorRes
import androidx.annotation.DimenRes
import androidx.core.content.ContextCompat

/**
 * @author kaibo
 * @date 2019/4/18 17:59
 * @GitHub：https://github.com/yuxuelian
 * @email：kaibo1hao@gmail.com
 * @description：
 */

internal inline fun Context.dimen(@DimenRes resource: Int): Int = resources.getDimensionPixelSize(resource)

internal inline fun View.dimen(@DimenRes resource: Int): Int = context.dimen(resource)
internal inline fun View.color(@ColorRes resource: Int) = ContextCompat.getColor(context, resource)