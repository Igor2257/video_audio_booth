package com.spacecompany.video_audio_booth

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
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
import androidx.core.app.ActivityCompat
import com.spacecompany.video_audio_booth.camera.TestCamera
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory
import java.io.File

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "com.spacecompany.video_audio_booth"
    private lateinit var dualCameraView: DualCameraView

    @RequiresApi(Build.VERSION_CODES.O)
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        if (ActivityCompat.checkSelfPermission(
                this,
                Manifest.permission.WRITE_EXTERNAL_STORAGE
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            Log.e("TestCamera", "Нет разрешения на запись в хранилище")
            // Запрос разрешений
            ActivityCompat.requestPermissions(
                this,
                arrayOf(Manifest.permission.WRITE_EXTERNAL_STORAGE),
                1
            )
        }
        val assetManager = applicationContext.assets
        val files = assetManager.list("")?.flatMap { dir ->
            assetManager.list(dir)?.map { "$dir/$it" } ?: listOf(dir)
        }
        Log.d("Assets", "Files: ${files?.joinToString(", ")}")


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
                    dualCameraView.startDualCamera()  // Start camera when method is called
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
        Log.d("123", "init")
        lastView = view // Запоминаем созданный экземпляр
        return view
    }
}


class DualCameraView(context: Context) : FrameLayout(context), PlatformView {

    private val textureViewBack: TextureView
    private val textureViewFront: TextureView
    private lateinit var backCamera: TestCamera
    private lateinit var frontCamera: TestCamera
    private lateinit var outputDirectory: File

    init {
        val inflater = LayoutInflater.from(context)
        val view = inflater.inflate(R.layout.camera_view, this, false)
        addView(view) // Add layout to the current FrameLayout
        outputDirectory = getOutputDirectory()
        val screenWidth = resources.displayMetrics.widthPixels
// Ширина переднего TextureView (1/4 от ширины экрана)
        val viewWidth = screenWidth / 4
// Высота переднего TextureView (соотношение 3:4, но пропорция высоты будет в пределах экрана)
        val viewHeight = screenWidth / 3

        textureViewBack = view.findViewById(R.id.textureViewBack)
        textureViewFront = view.findViewById(R.id.textureViewFront)

// Устанавливаем параметры для textureViewFront
        val layoutParams = textureViewFront.layoutParams
        layoutParams.width = viewWidth
        layoutParams.height = viewHeight

        textureViewFront.layoutParams = layoutParams


        backCamera = TestCamera(context, outputDirectory.absolutePath, "324324", "back", "1221")
        frontCamera = TestCamera(context, outputDirectory.absolutePath, "432324", "front", "1221")


        // Now cameras will be opened only when startDualCamera is called
    }

    // Method to start both cameras and show the preview
    @RequiresApi(Build.VERSION_CODES.O)
    fun startDualCamera() {
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

        startRecording()  // Start recording when cameras are opened
    }

    // Start recording both cameras
    @RequiresApi(Build.VERSION_CODES.O)
    fun startRecording() {
        backCamera.startRecordingCycle("0")
        frontCamera.startRecordingCycle("1")
    }

    // Stop recording both cameras
    fun stopRecording() {
        backCamera.stopRecording()
        frontCamera.stopRecording()
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
                val capabilities =
                    characteristics.get(CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES)
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


    override fun onAttachedToWindow() {
        super.onAttachedToWindow()
        // Reinitialize camera when the view is attached to window
        if (textureViewBack.isAvailable && textureViewFront.isAvailable) {
            backCamera.openCamera("0", textureViewBack)
            frontCamera.openCamera("1", textureViewFront)
        }
    }

    override fun onDetachedFromWindow() {
        super.onDetachedFromWindow()
        // Close cameras when the view is detached from window
        backCamera.closeCamera()
        frontCamera.closeCamera()
    }

    private fun getOutputDirectory(): File {
        if (!::outputDirectory.isInitialized) {
            outputDirectory = context.externalMediaDirs.firstOrNull()?.let {
                File(it, "dual_camera_videos").apply { mkdirs() }
            } ?: context.filesDir
        }
        return outputDirectory
    }
}


