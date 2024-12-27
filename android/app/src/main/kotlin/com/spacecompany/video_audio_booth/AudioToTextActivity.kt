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
                isListening = false
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
                    isListening = false
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
                    sendRecognizedTextToFlutter(partialMatch) // Отправляем промежуточный текст
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
            speechRecognizer.stopListening()
        }
        Handler(Looper.getMainLooper()).postDelayed({
            startSpeechRecognition()
        }, 1000)
    }

    fun startSpeechRecognition() {
        if (isListening) {
            Log.d("SpeechRecognizer", "Уже выполняется распознавание.")
            return
        }
        isListening = true
        val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(
                RecognizerIntent.EXTRA_LANGUAGE_MODEL,
                RecognizerIntent.LANGUAGE_MODEL_FREE_FORM
            )
            putExtra(RecognizerIntent.EXTRA_PROMPT, "Говорите сейчас")
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
