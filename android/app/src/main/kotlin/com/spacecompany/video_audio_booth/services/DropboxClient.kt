package com.spacecompany.video_audio_booth.services

import android.content.Context
import android.util.Log
import com.dropbox.core.DbxRequestConfig
import com.dropbox.core.v2.DbxClientV2
import io.flutter.embedding.engine.loader.FlutterLoader
import io.github.cdimascio.dotenv.Dotenv
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.io.File
import java.io.FileInputStream
import java.nio.charset.Charset

class DropboxClient(private val context: Context, private val localPath: String, private val uuid: String, private val occasionId: String) {
    private val config = DbxRequestConfig("video-booth")
    private val dropBoxToken = getValueForKey(context, "DROPBOX_ACCESS_TOKEN")

    // Асинхронный метод для загрузки файла в Dropbox
    fun uploadFile(fileName: String) {
        GlobalScope.launch(Dispatchers.IO) {
            try {
                val client = DbxClientV2(config, dropBoxToken)
                val file = File("${localPath}/${fileName}")

                // Проверка существования файла
                if (!file.exists()) {
                    Log.e("DropboxClient", "Файл $fileName не найден")
                    return@launch
                }

                val dropboxPath = "/occasions/$uuid/${occasionId}/${fileName}.mp4"

                // Открытие потока и загрузка файла в Dropbox
                FileInputStream(file).use { inputStream ->
                    client.files().uploadBuilder(dropboxPath)
                        .uploadAndFinish(inputStream)
                }

                Log.d("DropboxClient", "Файл загружен: $dropboxPath")
            } catch (e: Exception) {
                // Логирование ошибки при загрузке
                Log.e("DropboxClient", "Ошибка при загрузке файла в Dropbox: ${e.message}", e)
            }
        }
    }

    private fun loadEnvFromFlutterAssets(context: Context): Map<String, String> {
        val flutterLoader = FlutterLoader()
        flutterLoader.startInitialization(context)
        flutterLoader.ensureInitializationComplete(context, null)

        val assetManager = context.assets
        val envFileName = flutterLoader.getLookupKeyForAsset(".env")
        val content = assetManager.open(envFileName).bufferedReader(Charset.defaultCharset()).use { it.readText() }

        // Разбираем .env в Map
        val envMap = mutableMapOf<String, String>()
        content.split("\n").forEach { line ->
            val parts = line.split("=")
            if (parts.size == 2) {
                envMap[parts[0].trim()] = parts[1].trim()
            }
        }
        return envMap
    }

    fun getValueForKey(context: Context, key: String): String? {
        val envMap = loadEnvFromFlutterAssets(context)
        return envMap[key]
    }
}
