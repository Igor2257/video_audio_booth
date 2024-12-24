package com.spacecompany.video_audio_booth

import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.speech.RecognitionListener
import android.speech.RecognizerIntent
import android.speech.SpeechRecognizer
import android.util.Log
import java.io.File
import java.io.FileWriter
import java.io.IOException
class AudioToTextService(private val context: Context) {

    private lateinit var speechRecognizer: SpeechRecognizer
    private lateinit var videoOutputDirectory: File

    init {
        // Инициализация SpeechRecognizer
        speechRecognizer = SpeechRecognizer.createSpeechRecognizer(context)

        // Установка слушателя для распознавания речи
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
            }

            override fun onError(error: Int) {
                Log.e("SpeechRecognizer", "Ошибка: $error")
            }

            override fun onResults(results: Bundle?) {
                val matches = results?.getStringArrayList(SpeechRecognizer.RESULTS_RECOGNITION)
                matches?.forEach { match ->
                    Log.d("SpeechRecognizer", "Распознанный текст: $match")
                    // Сохраняем текст в файл
                    saveTextToFile(match)
                }
            }

            override fun onPartialResults(partialResults: Bundle?) {
                // Промежуточные результаты
            }

            override fun onEvent(eventType: Int, params: Bundle?) {
                // Специальные события
            }
        })
    }

    // Метод для начала распознавания речи с микрофона
    fun startSpeechRecognition() {
        val intent = Intent(RecognizerIntent.ACTION_RECOGNIZE_SPEECH).apply {
            putExtra(RecognizerIntent.EXTRA_LANGUAGE_MODEL, RecognizerIntent.LANGUAGE_MODEL_FREE_FORM)
            putExtra(RecognizerIntent.EXTRA_PROMPT, "Говорите теперь")
            putExtra(RecognizerIntent.EXTRA_SPEECH_INPUT_MINIMUM_LENGTH_MILLIS, 50000000000) // Устанавливаем длинный тайм-аут
            putExtra(RecognizerIntent.EXTRA_MAX_RESULTS, 5000) // Лимитируем количество результатов
            putExtra(RecognizerIntent.EXTRA_SPEECH_INPUT_POSSIBLY_COMPLETE_SILENCE_LENGTH_MILLIS, 50000000) // Лимитируем количество результатов
        }

        // Начало распознавания с микрофона
        speechRecognizer.startListening(intent)
    }

    // Метод для остановки распознавания речи
    fun stopSpeechRecognition() {
        // Останавливаем распознавание
        speechRecognizer.stopListening()
        Log.d("SpeechRecognizer", "Распознавание речи остановлено.")
    }

    private fun getOutputDirectory(): File {
        if (!::videoOutputDirectory.isInitialized) {
            videoOutputDirectory = context.externalMediaDirs.firstOrNull()?.let {
                File(it, "dual_camera_videos").apply { mkdirs() }
            } ?: context.filesDir
        }
        return videoOutputDirectory
    }

    // Сохранение распознанного текста в файл
    private fun saveTextToFile(text: String) {
        val file = File(getOutputDirectory(), "recognized_text.txt")
        try {
            FileWriter(file).apply { // Убираем параметр true, чтобы файл перезаписывался
                write(text) // Записываем текст в файл
                close()
            }
            Log.d("AudioToTextService", "Текст успешно сохранен в файл: ${file.absolutePath}")
        } catch (e: IOException) {
            Log.e("AudioToTextService", "Ошибка при сохранении текста в файл", e)
        }
    }


    // Очистка ресурсов
    fun destroy() {
        speechRecognizer.destroy()
    }
}
