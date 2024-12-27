package com.spacecompany.video_audio_booth

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import androidx.annotation.NonNull
import androidx.camera.view.PreviewView
import com.spacecompany.video_audio_booth.camera.CameraViewFactory
import com.spacecompany.video_audio_booth.camera.UnifiedCameraService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.spacecompany.video_audio_booth"
    private lateinit var audioToTextService: AudioToTextService

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val view: View = LayoutInflater.from(this).inflate(R.layout.camera_view, null)

        flutterEngine
            .platformViewsController
            .registry
            .registerViewFactory("<camera_view>", CameraViewFactory(view))

        val cameraChannel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        val cameraPreview: PreviewView = view.findViewById(R.id.camera_view)
        val frontCameraPreview: PreviewView = view.findViewById(R.id.front_camera_view)

        val cameraController =
            UnifiedCameraService(this, this, cameraPreview, frontCameraPreview, cameraChannel)

        val appView = AppView()
        cameraChannel.setMethodCallHandler { call: MethodCall, result: MethodChannel.Result ->
            appView.handle(call, result, cameraController, this)
        }

        // Инициализация AudioToTextService
        audioToTextService = AudioToTextService(this)

        // Настройка EventChannel для передачи текста
        // Настройка EventChannel для передачи текста
        val eventChannel = EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            "com.spacecompany.text_recognize"  // Новый канал с правильным именем
        )
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                Log.d("EventChannel", "Подключен EventSink")  // Лог для проверки
                audioToTextService.setEventSink(events) // Подключаем EventSink
                audioToTextService.startSpeechRecognition() // Запускаем распознавание
            }

            override fun onCancel(arguments: Any?) {
                Log.d("EventChannel", "EventSink отменен")  // Лог для проверки
                audioToTextService.setEventSink(null)
                audioToTextService.stopSpeechRecognition() // Останавливаем распознавание
            }
        })


    }
}
