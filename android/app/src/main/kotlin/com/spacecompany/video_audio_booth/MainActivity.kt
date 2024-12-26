package com.spacecompany.video_audio_booth

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.annotation.NonNull
import androidx.camera.view.PreviewView
import com.spacecompany.video_audio_booth.camera.CameraViewController
import com.spacecompany.video_audio_booth.camera.CameraViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.spacecompany.video_audio_booth"


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val view: View = LayoutInflater.from(this).inflate(R.layout.camera_view, null)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("<camera_view>", CameraViewFactory(view))

        val cameraChannel =
            MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        val cameraPreview: PreviewView = view.findViewById(R.id.camera_view)
        val frontCameraPreview: PreviewView = view.findViewById(R.id.front_camera_view)
        val params: ViewGroup.LayoutParams = frontCameraPreview.layoutParams
        val scale: Float = resources.displayMetrics.density
        params.width = (100 * scale + 0.5f).toInt() // dp to px
        params.height = (100 * scale + 0.5f).toInt() // dp to px
        frontCameraPreview.setLayoutParams(params)

        val cameraController = CameraViewController(this, this, cameraPreview,frontCameraPreview)
        val cameraManager = AppView()

        cameraChannel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            cameraManager.handle(call, result, cameraController, this)
        }
    }


}