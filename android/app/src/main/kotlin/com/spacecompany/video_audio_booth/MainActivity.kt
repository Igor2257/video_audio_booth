package com.spacecompany.video_audio_booth

import android.annotation.SuppressLint
import android.content.Context
import android.graphics.SurfaceTexture
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import android.util.Log
import android.view.LayoutInflater
import android.view.TextureView
import android.view.View
import android.widget.FrameLayout
import androidx.annotation.NonNull
import com.spacecompany.video_audio_booth.camera.TestCamera
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.StandardMessageCodec
import io.flutter.plugin.platform.PlatformView
import io.flutter.plugin.platform.PlatformViewFactory


class MainActivity : FlutterFragmentActivity() {


    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("camera-view", CameraViewFactory())

    }


}


class CameraViewFactory : PlatformViewFactory(StandardMessageCodec.INSTANCE) {
    override fun create(context: Context, id: Int, args: Any?): PlatformView {
        return DualCameraView(context)
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
        addView(view)

        textureViewBack = view.findViewById(R.id.textureViewBack)
        textureViewFront = view.findViewById(R.id.textureViewFront)

        backCamera = TestCamera(context)
        frontCamera = TestCamera(context)

        val (backCameraId, frontCameraId) = getCameraIds(context)
        if (backCameraId != null) {
            backCamera.openCamera(backCameraId, textureViewBack)
        } else {
            Log.e("CameraError", "Не удалось найти заднюю камеру!")
        }
        Log.d("backCameraId", backCameraId.toString())
        if (frontCameraId != null) {
            frontCamera.openCamera(frontCameraId, textureViewFront)
        } else {
            Log.e("CameraError", "Не удалось найти переднюю камеру!")
        }



    }

    @SuppressLint("ServiceCast")
    private fun getCameraIds(context: Context): Pair<String?, String?> {
        val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        var backCameraId: String? = null
        var frontCameraId: String? = null

        for (cameraId in cameraManager.cameraIdList) {
            val characteristics = cameraManager.getCameraCharacteristics(cameraId)
            val lensFacing = characteristics.get(CameraCharacteristics.LENS_FACING)

            if (lensFacing == CameraCharacteristics.LENS_FACING_FRONT && frontCameraId == null) {
                // Берем первую попавшуюся переднюю камеру
                frontCameraId = cameraId
                Log.d("CameraFilter", "Выбрана передняя камера: $cameraId")
            } else if (lensFacing == CameraCharacteristics.LENS_FACING_BACK) {
                // Проверяем, является ли камера "основной"
                val capabilities = characteristics.get(CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES)

                if (capabilities?.contains(CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES_BACKWARD_COMPATIBLE) == true) {
                    Log.d("CameraFilter", "Основная задняя камера: $cameraId")
                    if (backCameraId == null) {  // Берем только первую найденную основную камеру
                        backCameraId = cameraId
                    }
                } else {
                    Log.d("CameraFilter", "Пропускаем дополнительную камеру: $cameraId")
                }
            }
        }

        Log.d("CameraFilter", "Итоговая задняя камера: $backCameraId, передняя: $frontCameraId")
        return Pair(backCameraId, frontCameraId)
    }





    override fun dispose() {
        // Clean up resources (close cameras)
        backCamera.closeCamera()
        frontCamera.closeCamera()
    }

    override fun getView(): View {
        return this
    }
}
