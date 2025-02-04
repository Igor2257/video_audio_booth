package com.spacecompany.video_audio_booth.camera

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.graphics.SurfaceTexture
import android.hardware.camera2.CameraCaptureSession
import android.hardware.camera2.CameraDevice
import android.hardware.camera2.CameraManager
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

class TestCamera(private val context: Context)  {

    private var cameraDevice: CameraDevice? = null
    private var cameraCaptureSession: CameraCaptureSession? = null
    private lateinit var surfaceTexture: SurfaceTexture
    private lateinit var textureView: TextureView
    private lateinit var mediaRecorder: MediaRecorder
    private lateinit var outputDirectory: File

    private val handler = Handler(Looper.getMainLooper())
    private var isRecording = false
    private var videoStartTime = System.currentTimeMillis()

    fun openCamera(cameraId: String, textureView: TextureView) {
        this.textureView = textureView
        if (textureView.isAvailable) {
            surfaceTexture = textureView.surfaceTexture!!
            setupCamera(cameraId)
        } else {
            textureView.surfaceTextureListener = object : TextureView.SurfaceTextureListener {
                override fun onSurfaceTextureAvailable(surface: SurfaceTexture, width: Int, height: Int) {
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
        val previewSurface = Surface(surfaceTexture)

        val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        if (ActivityCompat.checkSelfPermission(context, Manifest.permission.CAMERA) != PackageManager.PERMISSION_GRANTED) {
            Log.e("TestCamera", "Нет разрешения на использование камеры")
            return
        }

        cameraManager.openCamera(cameraId, object : CameraDevice.StateCallback() {
            @RequiresApi(Build.VERSION_CODES.O)
            override fun onOpened(camera: CameraDevice) {
                cameraDevice = camera
                setupMediaRecorder()
                val recorderSurface = mediaRecorder.surface

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

    private fun getOutputDirectory(): File {
        if (!::outputDirectory.isInitialized) {
            outputDirectory = context.externalMediaDirs.firstOrNull()?.let {
                File(it, "dual_camera_videos").apply { mkdirs() }
            } ?: context.filesDir
        }
        return outputDirectory
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun setupMediaRecorder() {
        // Убедитесь, что путь для записи существует
        val outputFile = File(getOutputDirectory(), "${System.currentTimeMillis()}.mp4").absolutePath
        Log.d("TestCamera", "Начинаем настройку MediaRecorder для файла: $outputFile")

        mediaRecorder = MediaRecorder().apply {
            reset()
            setVideoSource(MediaRecorder.VideoSource.SURFACE)
            setOutputFile(outputFile)
            setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)
            setVideoEncoder(MediaRecorder.VideoEncoder.DEFAULT)
            prepare()
        }

    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun startRecording() {
        if (!::mediaRecorder.isInitialized) {
            Log.e("TestCamera", "MediaRecorder не был инициализирован!")
            handler.postDelayed({ startRecording() }, 1000)
            return
        }
        if (!isRecording) {
            try {
                mediaRecorder.start()
                isRecording = true
                videoStartTime = System.currentTimeMillis() // Убедитесь, что это обновляется при запуске записи
                Log.d("TestCamera", "Запись началась")
            } catch (e: Exception) {
                Log.e("TestCamera", "Ошибка при начале записи: ${e.message}")
                handler.postDelayed({ startRecording() }, 1000)
            }
        }

    }

    fun stopRecording() {
        if (isRecording) {
            try {
                Thread.sleep(100)  // Добавление задержки перед остановкой записи

                mediaRecorder.stop()
                mediaRecorder.reset()
                mediaRecorder.release()
                isRecording = false
                Log.d("TestCamera", "Запись успешно остановлена")
            } catch (e: IllegalStateException) {
                Log.e("TestCamera", "Ошибка при остановке записи: ${e.message}")
            } catch (e: Exception) {
                Log.e("TestCamera", "Неизвестная ошибка при остановке записи: ${e.message}")
                e.printStackTrace()
            }
        } else {
            Log.d("TestCamera", "Запись не была начата или уже остановлена.")
        }

    }



    fun closeCamera() {
        cameraCaptureSession?.close()
        cameraDevice?.close()
    }

    // Функция для циклической записи
    @RequiresApi(Build.VERSION_CODES.O)
    fun startRecordingCycle(name:String) {
        startRecording()
        val recordingRunnable = object : Runnable {
            @RequiresApi(Build.VERSION_CODES.O)
            override fun run() {
                Log.d("TestCamera",(isRecording).toString())
                Log.d("TestCamera",(System.currentTimeMillis()).toString())
                Log.d("TestCamera",(isRecording && (System.currentTimeMillis() - videoStartTime) >= 10000).toString())
                if (isRecording && (System.currentTimeMillis() - videoStartTime) >= 10000) {
                    stopRecording()
                    setupCamera(name)
                    // Добавьте задержку для гарантии, что MediaRecorder освободился
                    startRecording()  // Start a new recording
                }
                handler.postDelayed(this, 1000)
            }
        }
        handler.post(recordingRunnable)
    }

}
