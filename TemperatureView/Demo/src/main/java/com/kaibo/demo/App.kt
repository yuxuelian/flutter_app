package com.kaibo.demo

import android.app.Application
import android.content.ContextWrapper

/**
 * @author kaibo
 * @date 2019/4/18 17:21
 * @GitHub：https://github.com/yuxuelian
 * @email：kaibo1hao@gmail.com
 * @description：
 */

private lateinit var AppInstance: App

object AppContext : ContextWrapper(AppInstance)

class App : Application() {
    override fun onCreate() {
        super.onCreate()
        AppInstance = this
    }
}