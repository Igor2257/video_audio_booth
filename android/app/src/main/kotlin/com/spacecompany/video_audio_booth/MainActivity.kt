package com.spacecompany.video_audio_booth

import android.content.Context
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import android.util.Log
import androidx.annotation.NonNull
import androidx.lifecycle.Lifecycle
import androidx.lifecycle.LifecycleOwner
import androidx.lifecycle.LifecycleRegistry
import com.spacecompany.video_audio_booth.camera.CameraViewController
import com.spacecompany.video_audio_booth.camera.UnifiedCameraService
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.spacecompany.video_audio_booth"
    private val CHANNEL2 = "com.spacecompany.text"
    private lateinit var audioToTextService: AudioToTextService
    private lateinit var appView: AppView  // Reference to AppView
    private lateinit var cameraController: UnifiedCameraService  // Store camera controller

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        Log.d("ISAvailable", isCamera2Supported().toString())
        logCameraCharacteristics(this)
        // Инициализация appView
        appView = AppView()


        // Настройка EventChannel для передачи текста
        val eventChannel = EventChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL2 // Новый канал с правильным именем
        )



        audioToTextService = AudioToTextService(this)
        // Настройка StreamHandler для обработки данных из EventChannel
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

        // Настройка MethodChannel для выполнения односторонних методов
        val methodChannel = MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        )
        // Инициализация cameraController
        val backLifecycleOwner = CameraLifecycleOwner()
        val frontLifecycleOwner = CameraLifecycleOwner()
        //  cameraController.startCamera()
        methodChannel.setMethodCallHandler { call, result ->
            appView.handle(
                call,
                result,
                CameraViewController(this, audioToTextService),
                context,
                audioToTextService
            )
        }

    }

    private fun logCameraCharacteristics(context: Context) {
        val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        Log.d("CameraCheck", "Начало проверки камер")
        for (cameraId in cameraManager.cameraIdList) {
            Log.d("CameraCheck", "Информация о камере $cameraId:")
            val characteristics = cameraManager.getCameraCharacteristics(cameraId)

            // Логирование основных характеристик
            characteristics.keys.forEach { key ->
                try {
                    val value = characteristics[key]
                    Log.d("CameraCheck", "Ключ: ${key.name}, Значение: ${value.toString()}")
                } catch (e: Exception) {
                    Log.e("CameraCheck", "Ошибка чтения ключа ${key.name}", e)
                }
            }
            // Дополнительная информация (общая)
            val capabilities =
                characteristics.get(CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES)
            val hardwareLevel =
                characteristics.get(CameraCharacteristics.INFO_SUPPORTED_HARDWARE_LEVEL)
            val outputFormats =
                characteristics.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP)?.outputFormats

            // Логирование особенностей камеры
            Log.d("CameraCheck", "Возможности камеры: ${capabilities?.joinToString()}")
            Log.d("CameraCheck", "Уровень аппаратной поддержки: $hardwareLevel")
            Log.d("CameraCheck", "Доступные форматы вывода: ${outputFormats?.joinToString()}")
            if (capabilities != null && capabilities.contains(
                    CameraCharacteristics.REQUEST_AVAILABLE_CAPABILITIES_BACKWARD_COMPATIBLE
                )
            ) {
                Log.d("CameraCheck", "Камера $cameraId может поддерживать одновременную работу")
            } else {
                Log.d("CameraCheck", "Камера $cameraId имеет ограничения")
            }
            // Логирование физических характеристик
            val physicalSize = characteristics.get(CameraCharacteristics.SENSOR_INFO_PHYSICAL_SIZE)
            val resolution = characteristics.get(CameraCharacteristics.SENSOR_INFO_PIXEL_ARRAY_SIZE)
            Log.d("CameraCheck", "Физический размер сенсора: $physicalSize")
            Log.d("CameraCheck", "Разрешение сенсора: $resolution")

            // Логирование информации об ориентации и линзе
            val orientation = characteristics.get(CameraCharacteristics.LENS_FACING)
            Log.d("CameraCheck", "Ориентация камеры (FRONT=0, BACK=1): $orientation")
        }
    }


    private fun isCamera2Supported(): Boolean {
        val cameraManager = context.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        return try {
            for (cameraId in cameraManager.cameraIdList) {
                val characteristics = cameraManager.getCameraCharacteristics(cameraId)
                val level = characteristics.get(CameraCharacteristics.INFO_SUPPORTED_HARDWARE_LEVEL)
                if (level == CameraCharacteristics.INFO_SUPPORTED_HARDWARE_LEVEL_LEGACY) {
                    return false
                }
            }
            true
        } catch (e: Exception) {
            false
        }
    }

}


class CameraLifecycleOwner : LifecycleOwner {
    private val lifecycleRegistry = LifecycleRegistry(this)


    // Метод для изменения состояния жизненного цикла
    fun setState(state: Lifecycle.State) {
        lifecycleRegistry.currentState = state
    }

    override val lifecycle: Lifecycle
        get() = lifecycleRegistry
}


