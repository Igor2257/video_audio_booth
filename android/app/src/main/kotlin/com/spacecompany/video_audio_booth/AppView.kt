package com.spacecompany.video_audio_booth

import android.content.Context
import android.util.Log
import com.spacecompany.video_audio_booth.camera.UnifiedCameraService
import com.spacecompany.video_audio_booth.services.FileService
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import java.io.File


class AppView {

    fun handle(
        call: MethodCall,
        result: MethodChannel.Result,
        controller: UnifiedCameraService,
        context: Context
    ) {
        val fileService: FileService = FileService()
        when (call.method) {
            "stopSession" -> {
                // Завершаем сессию, если необходимо
            }

            "startSession" -> {
                controller.startCamera()
                // Возможно, здесь можно добавить другие действия, связанные с началом сессии
            }

            "startDualCamera" -> {
                // Запускаем распознавание речи
                val audioToTextService = AudioToTextService(context)
                audioToTextService.startSpeechRecognition()

                // Запускаем камеру
                controller.startCamera()

                Log.d("UnifiedCameraService", "Dual Camera Started")
                result.success("Dual Camera Started")
            }

            "stopDualCamera" -> {
                // Останавливаем распознавание речи
                val audioToTextService = AudioToTextService(context)
                audioToTextService.stopSpeechRecognition()

                // Останавливаем камеры
                controller.stopCamera()

                Log.d("UnifiedCameraService", "Dual Camera Stopped")
                result.success("Dual Camera Stopped")
            }

            "getAudioText" -> {
                result.success(
                    fileService.readFileTxtContent(
                        File(
                            fileService.getOutputDirectory(context),
                            "recognized_text.txt"
                        ).absolutePath
                    )
                )
            }

            "getBackVideoPath" -> {
                Log.d(
                    "FilePath",
                    "Back Video Path: ${
                        File(
                            fileService.getOutputDirectory(context),
                            "back_camera_video.mp4"
                        ).absolutePath
                    }"
                )

                result.success(
                    File(
                        fileService.getOutputDirectory(context),
                        "back_camera_video.mp4"
                    ).absolutePath
                )
            }

            "getFrontVideoPath" -> {
                Log.d(
                    "FilePath",
                    "Front Video Path: ${
                        File(
                            fileService.getOutputDirectory(context),
                            "front_camera_video.mp4"
                        ).absolutePath
                    }"
                )

                result.success(
                    File(
                        fileService.getOutputDirectory(context),
                        "front_camera_video.mp4"
                    ).absolutePath
                )
            }

            "startClassify" -> {
                val message = call.arguments?.toString()
                Log.d("Result", "message $message")
                val classifier = Classifier(context)
                classifier.load("text_classification_model.tflite", "word_dict.json") {
                    Log.d("Result", "Model loaded")
                    if (message != null) {
                        classifier.classify(message) { resultText ->
                            Log.d("Result Text", resultText)
                            result.success(resultText)
                        }
                    } else {
                        Log.d("Result", "Message is null")
                    }
                }
            }

            else -> result.notImplemented()
        }
    }
}

