package com.spacecompany.video_audio_booth

import android.content.Context
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import android.os.Build
import android.util.Log
import android.view.LayoutInflater
import android.view.TextureView
import android.view.View
import android.widget.FrameLayout
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import com.spacecompany.video_audio_booth.camera.TestCamera
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "com.spacecompany.video_audio_booth"
    private lateinit var dualCameraView: DualCameraView

    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val factory = CameraViewFactory()
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("camera-view", factory)

        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            val dualCameraView = factory.lastView
            if (dualCameraView == null) {
                result.error("NO_VIEW", "DualCameraView is not initialized", null)
                return@setMethodCallHandler
            }

            when (call.method) {
                "startDualCamera" -> {
                    dualCameraView.startRecording()
                    result.success(null)
                }
                "stopDualCamera" -> {
                    dualCameraView.stopRecording()
                    result.success(null)
                }
                else -> result.notImplemented()
            }
        }
    }

}


class CameraViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    var lastView: DualCameraView? = null

    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        val view = DualCameraView(context)
        lastView = view // Запоминаем созданный экземпляр
        return view
    }
}


class DualCameraView(context: Context) : FrameLayout(context), PlatformView {

    private val textureViewBack: TextureView
    private val textureViewFront: TextureView
    private lateinit var backCamera: TestCamera
    private lateinit var frontCamera: TestCamera

    init {
        val inflater = LayoutInflater.from(context)
        val view = inflater.inflate(R.layout.camera_view, this, false)
        addView(view) // Add layout to the current FrameLayout

        textureViewBack = view.findViewById(R.id.textureViewBack)
        textureViewFront = view.findViewById(R.id.textureViewFront)

        backCamera = TestCamera(context)
        frontCamera = TestCamera(context)

        val (backCameraId, frontCameraId) = getCameraIds(context)

        if (backCameraId != null) {
            backCamera.openCamera(backCameraId, textureViewBack)
        } else {
            Log.e("CameraError", "Could not find back camera!")
        }

        if (frontCameraId != null) {
            frontCamera.openCamera(frontCameraId, textureViewFront)
        } else {
            Log.e("CameraError", "Could not find front camera!")
        }
    }

    // Start recording both cameras
    @RequiresApi(Build.VERSION_CODES.O)
    fun startRecording() {
        backCamera.startRecording("back")

        frontCamera.startRecording("front")
    }

    // Stop recording both cameras
    fun stopRecording() {
        backCamera.stopRecording("back")
        frontCamera.stopRecording("front")
    }

    private fun getCameraIds(context: Context): Pair<String?, String?> {
        val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        var backCameraId: String? = null
        var frontCameraId: String? = null

        for (cameraId in cameraManager.cameraIdList) {
            val characteristics = cameraManager.getCameraCharacteristics(cameraId)
            val lensFacing = characteristics.get(CameraCharacteristics.LENS_FACING)

            if (lensFacing == CameraCharacteristics.LENS_FACING_FRONT && frontCameraId == null) {
                frontCameraId = cameraId
                Log.d("CameraFilter", "Front camera selected: $cameraId")
            } else if (lensFacing == CameraCharacteristics.LENS_FACING_BACK) {
                val capabilities = characteristics.get(CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES)
                if (capabilities?.contains(CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES_BACKWARD_COMPATIBLE) == true) {
                    if (backCameraId == null) {
                        backCameraId = cameraId
                    }
                }
            }
        }

        return Pair(backCameraId, frontCameraId)
    }

    override fun dispose() {
        backCamera.closeCamera()
        frontCamera.closeCamera()
    }

    override fun getView(): View {
        return this
    }
}
