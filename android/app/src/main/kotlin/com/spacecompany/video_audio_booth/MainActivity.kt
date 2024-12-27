package com.spacecompany.video_audio_booth

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import androidx.annotation.NonNull
import com.spacecompany.video_audio_booth.camera.CameraViewFactory
import com.spacecompany.video_audio_booth.camera.UnifiedCameraService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.spacecompany.video_audio_booth"
    private lateinit var audioToTextService: AudioToTextService
    private lateinit var appView: AppView  // Reference to AppView
    private lateinit var cameraController: UnifiedCameraService  // Store camera controller

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Инициализация appView
        appView = AppView()

        val view: View = LayoutInflater.from(this).inflate(R.layout.camera_view, null)

        // Регистрация канала
        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("<camera_view>", CameraViewFactory(view))

        // Настройка EventChannel для передачи текста
        val eventChannel = EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL // Новый канал с правильным именем
        )

        val context = this
        // Инициализация cameraController
        cameraController = UnifiedCameraService(
            context, context, view.findViewById(R.id.camera_view),
            view.findViewById(R.id.front_camera_view),
        )
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                Log.d("EventChannel", "onListen triggered")

                // Проверка на null
                if (events != null) {
                    audioToTextService.setEventSink(events) // Подключаем EventSink
                    audioToTextService.startSpeechRecognition() // Запускаем распознавание речи


                } else {
                    Log.e("EventChannel", "EventSink is null")
                }
            }

            override fun onCancel(arguments: Any?) {
                Log.d("EventChannel", "onCancel triggered")
                audioToTextService.setEventSink(null)
                audioToTextService.stopSpeechRecognition() // Останавливаем распознавание
            }
        })

    }
}


