package com.spacecompany.video_audio_booth.camera

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.graphics.SurfaceTexture
import android.hardware.camera2.CameraCaptureSession
import android.hardware.camera2.CameraDevice
import android.hardware.camera2.CameraManager
import android.media.MediaCodec
import android.media.MediaRecorder
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.Surface
import android.view.TextureView
import androidx.annotation.RequiresApi
import androidx.core.app.ActivityCompat
import java.io.File


class TestCamera(private val context: Context) {

    private var cameraDevice: CameraDevice? = null
    private var cameraCaptureSession: CameraCaptureSession? = null
    private lateinit var surfaceTexture: SurfaceTexture
    private lateinit var textureView: TextureView
    private lateinit var mediaRecorder: MediaRecorder
    private lateinit var outputDirectory: File

    private val handler = Handler(Looper.getMainLooper())

    fun openCamera(cameraId: String, textureView: TextureView) {
        this.textureView = textureView
        if (textureView.isAvailable) {
            surfaceTexture = textureView.surfaceTexture!!
            setupCamera(cameraId)
        } else {
            textureView.surfaceTextureListener = object : TextureView.SurfaceTextureListener {
                override fun onSurfaceTextureAvailable(
                    surface: SurfaceTexture,
                    width: Int,
                    height: Int
                ) {
                    surfaceTexture = surface
                    setupCamera(cameraId)
                }

                override fun onSurfaceTextureSizeChanged(
                    surface: SurfaceTexture,
                    width: Int,
                    height: Int
                ) {
                }

                override fun onSurfaceTextureDestroyed(surface: SurfaceTexture): Boolean {
                    closeCamera()
                    return true
                }

                override fun onSurfaceTextureUpdated(surface: SurfaceTexture) {}
            }
        }
    }

    private fun setupCamera(cameraId: String) {
        val previewSurface = Surface(surfaceTexture)  // For preview


        val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
            Log.e("TestCamera", "Нет разрешения на использование камеры")
            return
        }

        cameraManager.openCamera(cameraId, object : CameraDevice.StateCallback() {
            @RequiresApi(Build.VERSION_CODES.O)
            override fun onOpened(camera: CameraDevice) {
                cameraDevice = camera
                setupMediaRecorder(cameraId)
                val recorderSurface = mediaRecorder.surface  // For recording

                val captureRequestBuilder = camera.createCaptureRequest(CameraDevice.TEMPLATE_RECORD)
                captureRequestBuilder.addTarget(previewSurface)
                captureRequestBuilder.addTarget(recorderSurface)

                camera.createCaptureSession(listOf(previewSurface, recorderSurface), object : CameraCaptureSession.StateCallback() {
                    override fun onConfigured(session: CameraCaptureSession) {
                        cameraCaptureSession = session
                        session.setRepeatingRequest(captureRequestBuilder.build(), null, null)
                    }

                    override fun onConfigureFailed(session: CameraCaptureSession) {
                        Log.e("TestCamera", "Настройка сеанса камеры не удалась.")
                    }
                }, null)
            }

            override fun onDisconnected(camera: CameraDevice) {
                cameraDevice?.close()
            }

            override fun onError(camera: CameraDevice, error: Int) {
                if (error == CameraDevice.StateCallback.ERROR_CAMERA_IN_USE) {
                    Log.e("TestCamera", "Камера занята другим приложением. Попробую снова через 2 секунды.")
                    handler.postDelayed({ setupCamera(cameraId) }, 2000)
                } else {
                    Log.e("TestCamera", "Ошибка камеры: $error")
                }
            }
        }, null)
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun setupMediaRecorder(name: String) {
        val mySurface = MediaCodec.createPersistentInputSurface()
        Log.d("TestCamera", "Начинаем настройку MediaRecorder")
        mediaRecorder = MediaRecorder().apply {
            setVideoSource(MediaRecorder.VideoSource.SURFACE)
            setOutputFile(File(getOutputDirectory(), "${System.currentTimeMillis()}.mp4").absolutePath)
            setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)
            setVideoEncoder(MediaRecorder.VideoEncoder.DEFAULT)
            prepare()
        }

    }


    // Получаем директорию для сохранения
    private fun getOutputDirectory(): File {
        if (!::outputDirectory.isInitialized) {
            outputDirectory = context.externalMediaDirs.firstOrNull()?.let {
                File(it, "dual_camera_videos").apply { mkdirs() }
            } ?: context.filesDir
        }
        return outputDirectory
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun startRecording(name: String) {

        if (!::mediaRecorder.isInitialized) {
            Log.e("TestCamera", "MediaRecorder не был инициализирован!")
            return
        }
        mediaRecorder.start()
    }


    fun stopRecording(name: String) {
        if (!::mediaRecorder.isInitialized) {
            Log.e("TestCamera", "MediaRecorder не был инициализирован!")
            return
        }
        try {
            mediaRecorder.stop()
            mediaRecorder.reset()
            mediaRecorder.release()
            Log.d("TestCamera", "Запись успешно остановлена")
        } catch (e: Exception) {
            Log.e("TestCamera", "Ошибка при остановке записи: ${e.message}")
            mediaRecorder.reset()
            mediaRecorder.release()
        }

        // Safely close the camera and stop using it before restarting the camera session
        closeCamera()

        // Make sure the camera is fully released and not in use
        handler.postDelayed({
            setupCamera(name)  // Call after ensuring camera is closed properly
        }, 100)  // Slight delay to ensure that camera device is released
    }




    fun closeCamera() {
        cameraCaptureSession?.close()
        cameraDevice?.close()
    }

}
