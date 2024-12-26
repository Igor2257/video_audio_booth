package com.spacecompany.video_audio_booth.services

import android.content.Context
import java.io.File

class FileService {
    private lateinit var videoOutputDirectory: File
    public fun readFileTxtContent(filePath: String): String {
        val file = File(filePath)
        if (!file.exists()) {
            throw IllegalArgumentException("File does not exist at path: $filePath")
        }
        return file.readText()
    }

    public fun getOutputDirectory(context: Context): File {

        if (!::videoOutputDirectory.isInitialized) {
            videoOutputDirectory = context.externalMediaDirs.firstOrNull()?.let {
                File(it, "dual_camera_videos").apply { mkdirs() }
            } ?: context.filesDir
        }
        return videoOutputDirectory
    }
}