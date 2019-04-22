package com.kaibo.demo

import android.media.MediaPlayer
import android.os.Bundle
import android.util.Log
import android.view.SurfaceHolder
import androidx.appcompat.app.AppCompatActivity
import kotlinx.android.synthetic.main.activity_main.*

class MainActivity : AppCompatActivity() {

    private val mediaPlayer by lazy {
        MediaPlayer.create(this, R.raw.video_snow)
    }

    private val holderCallback = object : SurfaceHolder.Callback {
        override fun surfaceCreated(holder: SurfaceHolder) {
            Log.d("PRETTY_LOGGER", "surfaceCreated")
        }

        override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) {
            Log.d("PRETTY_LOGGER", "surfaceChanged")
            mediaPlayer.setDisplay(holder)
        }

        override fun surfaceDestroyed(holder: SurfaceHolder) {
            Log.d("PRETTY_LOGGER", "surfaceDestroyed")
            mediaPlayer.setDisplay(null)
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        window.immersive(false)
        surfaceView.holder.addCallback(holderCallback)
        mediaPlayer.isLooping = true
    }

    override fun onResume() {
        super.onResume()
        mediaPlayer.start()
    }

    override fun onPause() {
        super.onPause()
        mediaPlayer.pause()
    }

    override fun onDestroy() {
        if (mediaPlayer.isPlaying) {
            mediaPlayer.stop()
            mediaPlayer.release()
        }
        super.onDestroy()
    }
}
