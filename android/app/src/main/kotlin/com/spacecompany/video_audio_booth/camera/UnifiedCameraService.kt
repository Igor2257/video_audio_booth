package com.spacecompany.video_audio_booth.camera

import android.content.Context
import android.graphics.SurfaceTexture
import android.hardware.camera2.*
import android.hardware.camera2.params.OutputConfiguration
import android.hardware.camera2.params.SessionConfiguration
import android.os.Build
import android.os.Handler
import android.os.HandlerThread
import android.util.Log
import android.view.Surface
import android.view.SurfaceHolder
import android.view.SurfaceView
import android.view.TextureView
import androidx.annotation.RequiresApi
import java.io.File
import java.util.concurrent.Executor

class UnifiedCameraService(
    private val context: Context,
    private val backCameraPreview: SurfaceView,
    private val frontCameraPreview: SurfaceView
) {

    private val cameraManager: CameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager

    private var backCameraId: String? =null
    private var frontCameraId: String? = null

    private var backCameraDevice: CameraDevice? = null
    private var frontCameraDevice: CameraDevice? = null

    private var backCaptureSession: CameraCaptureSession? = null
    private var frontCaptureSession: CameraCaptureSession? = null

    private val backHandlerThread = HandlerThread("BackCameraThread").apply { start() }
    private val frontHandlerThread = HandlerThread("FrontCameraThread").apply { start() }

    private val backHandler = Handler(backHandlerThread.looper)
    private val frontHandler = Handler(frontHandlerThread.looper)





    init {
        initializeCameraIds()
    }

    private fun initializeCameraIds() {
        for (cameraId in cameraManager.cameraIdList) {
            val characteristics = cameraManager.getCameraCharacteristics(cameraId)
            val lensFacing = characteristics[CameraCharacteristics.LENS_FACING]

            when (lensFacing) {
                CameraCharacteristics.LENS_FACING_BACK -> backCameraId = cameraId
                CameraCharacteristics.LENS_FACING_FRONT -> frontCameraId = cameraId
            }
        }
    }

    @RequiresApi(Build.VERSION_CODES.P)
    fun startCamera() {
        setupSurfaceViews()
        frontCameraId?.let { openCamera(it, frontHandler, ::onFrontCameraOpened) }
        backCameraId?.let { openCamera(it, backHandler, ::onBackCameraOpened) }


    }

    private fun setupSurfaceViews() {
        backCameraPreview.holder.addCallback(object : SurfaceHolder.Callback {
            @RequiresApi(Build.VERSION_CODES.P)
            override fun surfaceCreated(holder: SurfaceHolder) {
                Log.d("UnifiedCameraService", "Back camera surface created")
                backCameraId?.let { openCamera(it, backHandler, ::onBackCameraOpened) }
            }

            override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) {}
            override fun surfaceDestroyed(holder: SurfaceHolder) {}
        })

        frontCameraPreview.holder.addCallback(object : SurfaceHolder.Callback {
            @RequiresApi(Build.VERSION_CODES.P)
            override fun surfaceCreated(holder: SurfaceHolder) {
                Log.d("UnifiedCameraService", "Front camera surface created")
                frontCameraId?.let { openCamera(it, frontHandler, ::onFrontCameraOpened) }
            }

            override fun surfaceChanged(holder: SurfaceHolder, format: Int, width: Int, height: Int) {}
            override fun surfaceDestroyed(holder: SurfaceHolder) {}
        })
    }


    private fun openCamera(cameraId: String, handler: Handler, callback: (CameraDevice) -> Unit) {
        try {
            cameraManager.openCamera(cameraId, object : CameraDevice.StateCallback() {
                override fun onOpened(camera: CameraDevice) {
                    callback(camera)
                }

                override fun onDisconnected(camera: CameraDevice) {
                    camera.close()
                }

                override fun onError(camera: CameraDevice, error: Int) {
                    Log.e("UnifiedCameraService", "Error opening camera $cameraId: $error")
                    camera.close()
                }
            }, handler)
        } catch (e: SecurityException) {
            Log.e("UnifiedCameraService", "Permission denied to open camera $cameraId", e)
        } catch (e: Exception) {
            Log.e("UnifiedCameraService", "Failed to open camera $cameraId", e)
        }
    }

    @RequiresApi(Build.VERSION_CODES.P)
    private fun onBackCameraOpened(camera: CameraDevice) {
        backCameraDevice = camera
        val surface = backCameraPreview.holder.surface
        if (backCameraDevice == null || !backCameraPreview.holder.surface.isValid) {
            Log.e("UnifiedCameraService", "Back camera or surface invalid")
            return
        }

        createCaptureSession(camera, surface, backHandler, ::onBackCaptureSessionCreated)
    }

    @RequiresApi(Build.VERSION_CODES.P)
    private fun onFrontCameraOpened(camera: CameraDevice) {
        frontCameraDevice = camera
        val surface = frontCameraPreview.holder.surface
        if (frontCameraDevice == null || !frontCameraPreview.holder.surface.isValid) {
            Log.e("UnifiedCameraService", "Front camera or surface invalid")
            return
        }

        createCaptureSession(camera, surface, frontHandler, ::onFrontCaptureSessionCreated)
    }

    @RequiresApi(Build.VERSION_CODES.P)
    private fun createCaptureSession(
        camera: CameraDevice,
        surface: Surface,
        handler: Handler,
        callback: (CameraCaptureSession) -> Unit
    ) {
        try {
            // Создаем OutputConfiguration для каждой поверхности
            val outputConfig = OutputConfiguration(surface)

            // Создаем Executor с использованием Handler
            val executor: Executor = Executor { command -> handler.post(command) }

            // Настроим сессию
            val sessionConfig = SessionConfiguration(
                SessionConfiguration.SESSION_REGULAR,
                listOf(outputConfig),
                executor,
                object : CameraCaptureSession.StateCallback() {
                    override fun onConfigured(session: CameraCaptureSession) {
                        callback(session)
                    }

                    override fun onConfigureFailed(session: CameraCaptureSession) {
                        Log.e("UnifiedCameraService", "Failed to configure capture session for camera ${camera.id}")
                    }
                }
            )

            // Откроем сессию
            camera.createCaptureSession(sessionConfig)
        } catch (e: Exception) {
            Log.e("UnifiedCameraService", "Error creating capture session", e)
        }
    }

    private fun onBackCaptureSessionCreated(session: CameraCaptureSession) {
        backCaptureSession = session
        val builder = backCameraDevice?.createCaptureRequest(CameraDevice.TEMPLATE_STILL_CAPTURE) // Используем TEMPLATE_RECORD для записи
        builder?.addTarget(backCameraPreview.holder.surface)
        session.setRepeatingRequest(builder?.build()!!, null, backHandler)
    }

    private fun onFrontCaptureSessionCreated(session: CameraCaptureSession) {
        frontCaptureSession = session
        val builder = frontCameraDevice?.createCaptureRequest(CameraDevice.TEMPLATE_STILL_CAPTURE) // Используем TEMPLATE_RECORD для записи
        builder?.addTarget(frontCameraPreview.holder.surface)
        session.setRepeatingRequest(builder?.build()!!, null, frontHandler)
    }


    fun stopCamera() {
        // Ensure that resources are properly closed only if they are initialized
        backCaptureSession?.close()
        frontCaptureSession?.close()
        backCameraDevice?.close()
        frontCameraDevice?.close()
        backHandlerThread.quitSafely()
        frontHandlerThread.quitSafely()
    }
}
