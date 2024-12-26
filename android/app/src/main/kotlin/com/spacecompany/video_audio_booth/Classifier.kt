package com.spacecompany.video_audio_booth

import android.content.Context
import android.util.Log
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONObject
import org.tensorflow.lite.Interpreter
import org.tensorflow.lite.support.common.FileUtil
import java.io.IOException

class Classifier(private val context: Context) {

    private lateinit var vocabData: HashMap<String, Int>
    private lateinit var tfLiteInterpreter: Interpreter

    // Load model and vocab
    fun load(
        modelAssetsName: String,
        vocabAssetsName: String,
        onComplete: () -> Unit
    ) {
        CoroutineScope(Dispatchers.Default).launch {
            try {
                val interpreter = loadModel(modelAssetsName)
                val vocab = loadVocab(vocabAssetsName)
                if (vocab != null && interpreter != null) {
                    this@Classifier.vocabData = vocab
                    this@Classifier.tfLiteInterpreter = interpreter
                    withContext(Dispatchers.Main) {
                        onComplete()  // Notify completion on the main thread
                    }
                } else {
                    throw Exception("Failed to load model or vocab")
                }
            } catch (e: Exception) {
                Log.e("Result", "Error loading model or vocab: ${e.message}")
                withContext(Dispatchers.Main) {
                    onComplete()  // Notify failure on the main thread
                }
            }
        }
    }

    // Classify the given text
    fun classify(
        text: String,
        onComplete: ((String) -> Unit)
    ) {
        CoroutineScope(Dispatchers.Default).launch {
            try {
                // Tokenize and pad the input
                val inputs: Array<FloatArray> = arrayOf(
                    padSequence(tokenize(text))
                        .map { it.toFloat() }
                        .toFloatArray()
                )
                Log.d("Result", "inputs $inputs")

                // Adjust the output array size to match the model's output shape [2, 3] (2 samples, 3 categories)
                val outputs: Array<FloatArray> = Array(2) { FloatArray(3) }  // 2 samples, 3 categories

                // Run the model
                tfLiteInterpreter.run(inputs, outputs)

                // Get the output for the first input (row 0) or the one with the highest score
                val outputForFirstInput = outputs[0]

                // Get the index of the class with the highest score for the first input
                val classIndex = outputForFirstInput.indices.maxByOrNull { outputForFirstInput[it] } ?: -1
                val categories = listOf("Запитання", "Команди", "Опис або емоційний текст")

                // Return the classification result based on the highest score
                val resultText = if (classIndex != -1) categories[classIndex] else "Unknown"
                onComplete(resultText)

            } catch (e: Exception) {
                Log.e("Result", "Classification error: ${e.message}")
                onComplete("Error during classification")
            }
        }
    }


    // Tokenize the input message
    fun tokenize(message: String): IntArray {
        val newMessage = message
            .split(" ")
            .map { it.trim() }
            .filter { it.isNotEmpty() }
            .map { part -> vocabData[part] ?: 0 }  // Handle missing vocab gracefully
            .toIntArray()
        Log.d("Result", "Tokenized message: ${newMessage.joinToString()}")
        return newMessage
    }

    // Pad the sequence to a fixed size
    fun padSequence(sequence: IntArray): IntArray {
        val paddedSequence =
            IntArray(120) { 0 }  // Default pad size 120, can be parameterized if needed
        sequence.copyInto(paddedSequence, 0, 0, sequence.size)
        Log.d("Result", "Padded sequence: ${paddedSequence.joinToString()}")
        return paddedSequence
    }

    // Load vocab from the assets folder
    private suspend fun loadVocab(vocabAssetsName: String): HashMap<String, Int>? =
        withContext(Dispatchers.IO) {
            Log.d("Result", "Loading vocab from $vocabAssetsName")
            try {
                val inputStream = context.assets.open(vocabAssetsName)
                inputStream.use { stream ->
                    val jsonContents = stream.bufferedReader().readText()
                    val jsonObject = JSONObject(jsonContents)
                    val data = HashMap<String, Int>()
                    val iterator = jsonObject.keys()
                    while (iterator.hasNext()) {
                        val key = iterator.next()
                        val index = jsonObject.getInt(key)
                        data[key] = index
                    }
                    data
                }
            } catch (e: IOException) {
                Log.e("Result", "Error loading vocab: ${e.message}")
                null
            }
        }

    // Load TensorFlow Lite model from assets
    private suspend fun loadModel(modelAssetsName: String): Interpreter? =
        withContext(Dispatchers.IO) {
            Log.d("Result", "Loading model from $modelAssetsName")
            try {
                Interpreter(FileUtil.loadMappedFile(context, modelAssetsName))
            } catch (e: IOException) {
                Log.e("Result", "Error loading model: ${e.message}")
                null
            }
        }
}
