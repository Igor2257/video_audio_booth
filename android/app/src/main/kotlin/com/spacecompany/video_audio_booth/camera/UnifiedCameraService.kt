package com.spacecompany.video_audio_booth.camera

import android.content.Context
import android.os.Build
import androidx.camera.core.*
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.camera.view.PreviewView
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.lifecycle.LifecycleOwner
import com.spacecompany.video_audio_booth.MainActivity
import io.flutter.plugin.common.MethodChannel
import java.io.File
import androidx.camera.core.CameraSelector

class UnifiedCameraService(
    private val context: Context,
    private val lifecycleOwner: LifecycleOwner,
    private val cameraPreview: PreviewView,  // Для задней камеры
    private val cameraPreviewFront: PreviewView,  // Для фронтальной камеры
    private val cameraChannel: MethodChannel // Канал для общения с Flutter
) {

    private lateinit var cameraProvider: ProcessCameraProvider
    private lateinit var cameraSelectorBack: CameraSelector
    private lateinit var cameraSelectorFront: CameraSelector

    private var backCamera: Camera? = null
    private var frontCamera: Camera? = null

    // Привязка задней камеры для трансляции
    private fun bindBackCamera(cameraProvider: ProcessCameraProvider) {
        val previewBack = Preview.Builder()
            .build()
            .also {
                it.setSurfaceProvider(cameraPreview.surfaceProvider) // Указываем, на каком экране выводится изображение
            }

        try {
            // Привязываем заднюю камеру для трансляции
            backCamera = cameraProvider.bindToLifecycle(
                lifecycleOwner,
                cameraSelectorBack,
                previewBack
            )
            cameraChannel.invokeMethod("onCameraStatus", "Back camera bound for preview")
        } catch (exc: Exception) {
            exc.printStackTrace()
            cameraChannel.invokeMethod("onCameraStatus", "Back camera binding failed: ${exc.message}")
        }
    }

    // Привязка фронтальной камеры для трансляции
    private fun bindFrontCamera(cameraProvider: ProcessCameraProvider) {
        val previewFront = Preview.Builder()
            .build()
            .also {
                it.setSurfaceProvider(cameraPreviewFront.surfaceProvider) // Указываем, на каком экране выводится изображение
            }

        try {
            // Привязываем фронтальную камеру для трансляции
            frontCamera = cameraProvider.bindToLifecycle(
                lifecycleOwner,
                cameraSelectorFront,
                previewFront
            )
            cameraChannel.invokeMethod("onCameraStatus", "Front camera bound for preview")
        } catch (exc: Exception) {
            exc.printStackTrace()
            cameraChannel.invokeMethod("onCameraStatus", "Front camera binding failed: ${exc.message}")
        }
    }

    private fun initializeCameraProvider() {
        val cameraProviderFuture = ProcessCameraProvider.getInstance(context)
        cameraProviderFuture.addListener({
            cameraProvider = cameraProviderFuture.get()

            // Настройка камеры
            cameraSelectorBack = CameraSelector.Builder()
                .requireLensFacing(CameraSelector.LENS_FACING_BACK)
                .build()
            cameraSelectorFront = CameraSelector.Builder()
                .requireLensFacing(CameraSelector.LENS_FACING_FRONT)
                .build()

            // Привязка камер для трансляции
            bindBackCamera(cameraProvider)
            bindFrontCamera(cameraProvider)

        }, ContextCompat.getMainExecutor(context))
    }

    fun startCamera() {
        initializeCameraProvider()
    }

    fun stopCamera() {
        // Останавливаем камеры и отменяем привязку
        cameraProvider.unbindAll()
        cameraChannel.invokeMethod("onCameraStatus", "Cameras stopped")
    }
}
