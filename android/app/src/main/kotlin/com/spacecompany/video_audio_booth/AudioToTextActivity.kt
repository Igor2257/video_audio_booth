package com.spacecompany.video_audio_booth

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.speech.RecognitionListener
import android.speech.RecognizerIntent
import android.speech.SpeechRecognizer
import android.util.Log
import io.flutter.plugin.common.EventChannel
import java.io.File
import java.io.FileWriter
import java.io.IOException

class AudioToTextService(private val context: Context) {

    private lateinit var speechRecognizer: SpeechRecognizer
    private lateinit var videoOutputDirectory: File
    private var isListening = false
    private var shouldStopListening = false
    private var eventSink: EventChannel.EventSink? = null

    fun setEventSink(eventSink: EventChannel.EventSink?) {
        this.eventSink = eventSink
    }

    init {
        speechRecognizer = SpeechRecognizer.createSpeechRecognizer(context)
        speechRecognizer.setRecognitionListener(object : RecognitionListener {
            override fun onReadyForSpeech(params: Bundle?) {
                Log.d("SpeechRecognizer", "Готово к распознаванию речи.")
            }

            override fun onBeginningOfSpeech() {
                Log.d("SpeechRecognizer", "Начало речи.")
            }

            override fun onRmsChanged(rmsdB: Float) {
                // Изменение громкости
            }

            override fun onBufferReceived(buffer: ByteArray?) {
                // Получение аудиобуфера
            }

            override fun onEndOfSpeech() {
                Log.d("SpeechRecognizer", "Конец речи.")

                restartSpeechRecognition()
            }

            override fun onError(error: Int) {
                val errorMessage = when (error) {
                    SpeechRecognizer.ERROR_NETWORK -> "Ошибка сети"
                    SpeechRecognizer.ERROR_AUDIO -> "Ошибка аудиовхода"
                    SpeechRecognizer.ERROR_SERVER -> "Ошибка сервера"
                    SpeechRecognizer.ERROR_NO_MATCH -> "Нет совпадений"
                    SpeechRecognizer.ERROR_SPEECH_TIMEOUT -> "Превышено время ожидания"
                    else -> "Неизвестная ошибка"
                }
                Log.e("SpeechRecognizer", "Ошибка: $error ($errorMessage)")
                if (error != SpeechRecognizer.ERROR_CLIENT && error != SpeechRecognizer.ERROR_INSUFFICIENT_PERMISSIONS) {
                    restartSpeechRecognition()
                }
            }

            override fun onEvent(eventType: Int, params: Bundle?) {
                // Специальные события
            }

            override fun onResults(results: Bundle?) {
                val matches = results?.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION)
                matches?.forEach { match ->
                    Log.d("SpeechRecognizer", "Распознанный текст: $match")
                    sendRecognizedTextToFlutter(match) // Отправляем текст на Flutter
                }
                restartSpeechRecognition()
            }

            override fun onPartialResults(partialResults: Bundle?) {
                val partialMatches = partialResults?.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION)
                partialMatches?.forEach { partialMatch ->
                    Log.d("SpeechRecognizer", "Промежуточный текст: $partialMatch")
                    sendRecognizedTextToFlutter(partialMatch)
                }
            }


            // Остальные методы остаются без изменений...
        })
    }
    fun sendRecognizedTextToFlutter(text: String) {
        eventSink?.success(text) // Отправляем текст во Flutter
    }
    private fun saveTextToFile(text: String) {
        val file = File(getOutputDirectory(), "recognized_text.txt")
        try {
            FileWriter(file, true).apply {
                write("$text\n")
                close()
            }
            Log.d("AudioToTextService", "Текст успешно сохранен в файл: ${file.absolutePath}")
        } catch (e: IOException) {
            Log.e("AudioToTextService", "Ошибка при сохранении текста в файл", e)
        }
    }

    private fun restartSpeechRecognition() {
        if (shouldStopListening) return
        if (isListening) {
            isListening = false
            speechRecognizer.stopListening()
        }
        Handler(Looper.getMainLooper()).postDelayed({
            startNewListening()
        }, 1000)
    }

    fun startSpeechRecognition() {
        isListening=false
        shouldStopListening=false
        startNewListening()
    }
    private fun startNewListening(){
        Log.d("SpeechRecognizer", "Начало выполняется распознавание.")
        if (isListening) {
            Log.d("SpeechRecognizer", "Уже выполняется распознавание.")
            return
        }
        isListening = true
        val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(RecognizerIntent.EXTRA_SPEECH_INPUT_MINIMUM_LENGTH_MILLIS, 50000) // Устанавливаем длинный тайм-аут
            putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 5000) // Лимитируем количество результатов
            putExtra(RecognizerIntent.EXTRA_SPEECH_INPUT_POSSIBLY_COMPLETE_SILENCE_LENGTH_MILLIS, 50000)
        }
        speechRecognizer.startListening(intent)
    }

    fun stopSpeechRecognition() {
        shouldStopListening = true
        speechRecognizer.stopListening()
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
