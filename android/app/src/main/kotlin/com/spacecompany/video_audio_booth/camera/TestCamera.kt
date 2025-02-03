package com.spacecompany.video_audio_booth.camera

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.graphics.SurfaceTexture
import android.hardware.camera2.CameraCaptureSession
import android.hardware.camera2.CameraDevice
import android.hardware.camera2.CameraManager
import android.media.MediaRecorder
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.Surface
import android.view.TextureView
import androidx.core.app.ActivityCompat

class TestCamera(private val context: Context) {

    private var cameraDevice: CameraDevice? = null
    private var cameraCaptureSession: CameraCaptureSession? = null
    private lateinit var surfaceTexture: SurfaceTexture
    private lateinit var textureView: TextureView

    fun openCamera(cameraId: String, textureView: TextureView) {
        Log.d("TestCamera", "Попытка открыть камеру $cameraId")
        this.textureView = textureView
        if (textureView.isAvailable) {
            surfaceTexture = textureView.surfaceTexture!!
            Log.d("TestCamera", "TextureView доступен, вызываем setupCamera")
            setupCamera(cameraId)
        } else {
            textureView.surfaceTextureListener = object : TextureView.SurfaceTextureListener {
                override fun onSurfaceTextureAvailable(surface: SurfaceTexture, width: Int, height: Int) {
                    Log.d("TestCamera", "SurfaceTexture стал доступен, вызываем setupCamera")
                    surfaceTexture = surface
                    setupCamera(cameraId)
                }
                override fun onSurfaceTextureSizeChanged(surface: SurfaceTexture, width: Int, height: Int) {}
                override fun onSurfaceTextureDestroyed(surface: SurfaceTexture): Boolean {
                    closeCamera()
                    return true
                }
                override fun onSurfaceTextureUpdated(surface: SurfaceTexture) {}
            }
        }
    }



    private fun setupCamera(cameraId: String) {
        // Здесь мы гарантируем, что SurfaceTexture не null
        val surface = Surface(surfaceTexture)

        // Открытие камеры и настройка сеанса
        val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        if (ActivityCompat.checkSelfPermission(
                context,
                Manifest.permission.CAMERA
            ) != PackageManager.PERMISSION_GRANTED
        ) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            return
        }
        cameraManager.openCamera(cameraId, object : CameraDevice.StateCallback() {
            override fun onOpened(camera: CameraDevice) {
                cameraDevice = camera
                val captureRequestBuilder = camera.createCaptureRequest(CameraDevice.TEMPLATE_PREVIEW)
                captureRequestBuilder.addTarget(surface)
                camera.createCaptureSession(listOf(surface), object : CameraCaptureSession.StateCallback() {
                    override fun onConfigured(session: CameraCaptureSession) {
                        cameraCaptureSession = session
                        session.setRepeatingRequest(captureRequestBuilder.build(), null, null)
                    }

                    override fun onConfigureFailed(session: CameraCaptureSession) {
                        Log.e("TestCamera", "Camera session configuration failed.")
                    }
                }, null)
            }

            override fun onDisconnected(camera: CameraDevice) {
                cameraDevice?.close()
            }

            override fun onError(camera: CameraDevice, error: Int) {
                Log.e("TestCamera", "Camera error: $error")
            }
        }, null)
    }

    fun closeCamera() {
        cameraCaptureSession?.close()
        cameraDevice?.close()
    }
}
