package com.spacecompany.video_audio_booth.camera

import android.annotation.SuppressLint
import android.content.Context
import androidx.camera.core.AspectRatio
import androidx.camera.core.Camera
import androidx.camera.core.CameraSelector
import androidx.camera.core.Preview
import androidx.camera.lifecycle.ProcessCameraProvider
import androidx.camera.view.PreviewView
import androidx.core.content.ContextCompat
import androidx.lifecycle.LifecycleOwner
import com.google.common.util.concurrent.ListenableFuture
import io.flutter.Log

class CameraViewController(
    private val context: Context,
    private val lifecycleOwner: LifecycleOwner,
    camera: PreviewView,
    cameraFront: PreviewView,
) {

    private val cameraPreview: PreviewView = camera
    private val cameraPreviewFront: PreviewView = cameraFront
    private var cameraDevice: Camera? = null
    private var cameraDeviceFront: Camera? = null
    private var isInitialized = false
    private var currentLensFacing: CameraSelector = CameraSelector.DEFAULT_BACK_CAMERA
    private var currentLensFacingFront: CameraSelector = CameraSelector.DEFAULT_FRONT_CAMERA


    /**
     * To start camera preview and capture
     */
    @SuppressLint("MissingPermission", "RestrictedApi")
    fun startCamera(onInitialize: (result: Boolean?) -> Unit) {
        val cameraProviderFuture: ListenableFuture<ProcessCameraProvider> =
            ProcessCameraProvider.getInstance(context.applicationContext)
        val cameraProviderFutureFront: ListenableFuture<ProcessCameraProvider> =
            ProcessCameraProvider.getInstance(context.applicationContext)
        try {
            cameraProviderFutureFront.addListener({
                try {

                    val cameraProviderFront: ProcessCameraProvider = cameraProviderFutureFront.get()
                    val previewFront: Preview = Preview.Builder().apply {
                        setTargetAspectRatio(AspectRatio.RATIO_16_9)
                    }.build()
                    previewFront.setSurfaceProvider(cameraPreviewFront.surfaceProvider)
                    cameraPreviewFront.scaleType = PreviewView.ScaleType.FIT_END
                    try {
                        cameraProviderFront.unbindAll()
                        cameraDeviceFront = cameraProviderFront.bindToLifecycle(
                            lifecycleOwner,
                            currentLensFacingFront,
                            previewFront,
                        )
                        isInitialized = true
                    } catch (exc: Exception) {
                        Log.e("Camera", exc.toString())
                    }
                } catch (e: Exception) {
                    Log.e("Camera", e.toString())
                }
            }, ContextCompat.getMainExecutor(context))
            cameraProviderFuture.addListener({
                try {
                    // Used to bind the lifecycle of cameras to the lifecycle owner
                    val cameraProvider: ProcessCameraProvider = cameraProviderFuture.get()
                    val preview: Preview = Preview.Builder().apply {
                        setTargetAspectRatio(AspectRatio.RATIO_16_9)
                    }.build()
                    preview.setSurfaceProvider(cameraPreview.surfaceProvider)
                    cameraPreview.scaleType = PreviewView.ScaleType.FIT_CENTER
                    try {
                        // Unbind use cases before rebinding
                        cameraProvider.unbindAll()

                        // Bind use cases to camera
                        cameraDevice = cameraProvider.bindToLifecycle(
                            lifecycleOwner,
                            currentLensFacing,
                            preview,
                        )


                        isInitialized = true

                    } catch (exc: Exception) {
                        Log.e("Camera", exc.toString())
                    }
                } catch (e: Exception) {
                    Log.e("Camera", e.toString())
                }
            }, ContextCompat.getMainExecutor(context))

            onInitialize.invoke(isInitialized)

        } catch (e: Exception) {
            Log.e("Camera", e.toString())
        }
    }

    /**
     * To stop camera preview and capture
     */
    fun stopCamera(onStop: (result: Boolean?) -> Unit) {
        // if (isInitialized) {
        val cameraProviderFuture = ProcessCameraProvider.getInstance(context.applicationContext)
        try {
            val cameraProvider: ProcessCameraProvider = cameraProviderFuture.get()
            cameraProvider.unbindAll()
            cameraDevice = null
            isInitialized = false
            onStop.invoke(true)
        } catch (e: Exception) {
            e.printStackTrace()
            onStop.invoke(false)
        }
        //   }
    }


}