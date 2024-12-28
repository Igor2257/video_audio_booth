package com.spacecompany.video_audio_booth.camera

import android.Manifest
import android.content.Context
import android.content.pm.PackageManager
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraCaptureSession
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraDevice
import android.hardware.camera2.CameraManager
import android.media.MediaRecorder
import android.os.Handler
import android.os.Looper
import androidx.core.app.ActivityCompat
import com.spacecompany.video_audio_booth.AudioToTextService
import java.io.File

class CameraViewController(
    private val context: Context,
    private val audio: AudioToTextService,
) {
    private lateinit var backMediaRecorder: MediaRecorder
    private lateinit var frontMediaRecorder: MediaRecorder
    private lateinit var backCameraSession: CameraCaptureSession
    private lateinit var frontCameraSession: CameraCaptureSession

    private lateinit var videoOutputDirectory: File
    fun startDualCameraRecording() {
        val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager

        try {
            val backCameraId = cameraManager.cameraIdList.first { id ->
                cameraManager.getCameraCharacteristics(id)
                    .get(CameraCharacteristics.LENS_FACING) == CameraCharacteristics.LENS_FACING_BACK
            }

            val frontCameraId = cameraManager.cameraIdList.first { id ->
                cameraManager.getCameraCharacteristics(id)
                    .get(CameraCharacteristics.LENS_FACING) == CameraCharacteristics.LENS_FACING_FRONT
            }

            val mainHandler = Handler(Looper.getMainLooper())

            if (ActivityCompat.checkSelfPermission(
                    context, Manifest.permission.CAMERA
                ) != PackageManager.PERMISSION_GRANTED
            ) {

                return
            }

            cameraManager.openCamera(backCameraId, object : CameraDevice.StateCallback() {
                override fun onOpened(camera: CameraDevice) {
                    setupBackCamera(camera)
                }

                override fun onDisconnected(camera: CameraDevice) {
                    camera.close()
                }

                override fun onError(camera: CameraDevice, error: Int) {
                    camera.close()
                }
            }, mainHandler)

            cameraManager.openCamera(frontCameraId, object : CameraDevice.StateCallback() {
                override fun onOpened(camera: CameraDevice) {
                    setupFrontCamera(camera)
                }

                override fun onDisconnected(camera: CameraDevice) {
                    camera.close()
                }

                override fun onError(camera: CameraDevice, error: Int) {
                    camera.close()
                }
            }, mainHandler)

        } catch (e: CameraAccessException) {
            e.printStackTrace()
        }
    }

    private fun setupBackCamera(camera: CameraDevice) {
        backMediaRecorder = createMediaRecorder("back_camera_video.mp4")
        val surface = backMediaRecorder.surface
        val surfaces = listOf(surface)

        camera.createCaptureSession(surfaces, object : CameraCaptureSession.StateCallback() {
            override fun onConfigured(session: CameraCaptureSession) {
                backCameraSession = session
                val requestBuilder =
                    camera.createCaptureRequest(CameraDevice.TEMPLATE_RECORD).apply {
                        addTarget(surface)
                    }
                session.setRepeatingRequest(requestBuilder.build(), null, null)
                AudioToTextService(context).startSpeechRecognition()
                backMediaRecorder.start()
                audio.startSpeechRecognition()

            }

            override fun onConfigureFailed(session: CameraCaptureSession) {
                session.close()
            }
        }, null)
    }

    private fun setupFrontCamera(camera: CameraDevice) {
        frontMediaRecorder = createMediaRecorder("front_camera_video.mp4")
        val surface = frontMediaRecorder.surface
        val surfaces = listOf(surface)

        camera.createCaptureSession(surfaces, object : CameraCaptureSession.StateCallback() {
            override fun onConfigured(session: CameraCaptureSession) {
                frontCameraSession = session
                val requestBuilder =
                    camera.createCaptureRequest(CameraDevice.TEMPLATE_RECORD).apply {
                        addTarget(surface)
                    }
                session.setRepeatingRequest(requestBuilder.build(), null, null)
                frontMediaRecorder.start()
            }

            override fun onConfigureFailed(session: CameraCaptureSession) {
                session.close()
            }
        }, null)
    }

    private fun createMediaRecorder(fileName: String): MediaRecorder {
        val outputDir = getOutputDirectory()
        val videoFile = File(outputDir, fileName)
        return MediaRecorder().apply {
            setVideoSource(MediaRecorder.VideoSource.CAMERA)
            setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)
            setOutputFile(videoFile.absolutePath)
            setVideoEncoder(MediaRecorder.VideoEncoder.H264)
            setVideoFrameRate(30)
            setVideoSize(1920, 1080)
            setVideoEncodingBitRate(10000000)
            prepare()
        }
    }

    fun stopDualCameraRecording() {
        try {
            backMediaRecorder.stop()
            backMediaRecorder.reset()
            backMediaRecorder.release()

            frontMediaRecorder.stop()
            frontMediaRecorder.reset()
            frontMediaRecorder.release()
            audio .stopSpeechRecognition()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun getOutputDirectory(): File {
        if (!::videoOutputDirectory.isInitialized) {
            videoOutputDirectory = context.externalMediaDirs.firstOrNull()?.let {
                File(it, "dual_camera_videos").apply { mkdirs() }
            } ?: context.filesDir
        }
        return videoOutputDirectory
    }

}