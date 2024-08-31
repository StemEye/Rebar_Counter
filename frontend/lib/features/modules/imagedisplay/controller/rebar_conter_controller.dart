import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as img;
import 'isolate_inference.dart';

class RebarController extends GetxController {
  final rebarCount = 0.obs;
  final rebarPositions = <Offset>[].obs;
  late Interpreter interpreter;
  bool isModelLoaded = false;
  late IsolateInference isolateInference;

  @override
  void onInit() {
    super.onInit();
    loadModel();
  }

  Future<void> loadModel() async {
    try {
      interpreter = await Interpreter.fromAsset("assets/final_model.tflite");
      isModelLoaded = true;
      isolateInference = IsolateInference();
      await isolateInference.start();
      log('Model loaded and isolate started successfully.');
    } catch (e) {
      log('Error loading model: $e');
      Get.snackbar("Error", "Error loading model: $e");
    }
  }

  Future<void> countRebar(File imageFile) async {
    if (!isModelLoaded) {
      log("Model not loaded yet.");
      return;
    }

    try {
      log("Starting object detection...");
      print("image before detect : $imageFile");
      final result = await _detectObjects(imageFile);
      if (result.isEmpty) {
        log('Detection result is empty');
        Get.snackbar("Oh snap", "Detection result is empty");
        return;
      }

      rebarPositions.clear();
      rebarPositions.addAll(result.map((pos) => Offset(pos[0], pos[1])));
      rebarCount.value = rebarPositions.length;

      log('Rebar positions: $rebarPositions');
      log('Rebar count result: ${rebarCount.value}');
    } catch (e) {
      log('Error during inference: $e');
      Get.snackbar("Error", "Error during inference: $e");
    }
  }

  Future<Uint8List> _inference(InferenceModel inferenceModel) async {
    ReceivePort responsePort = ReceivePort();
    isolateInference.sendPort
        .send(inferenceModel..responsePort = responsePort.sendPort);
    // get inference result.
    var results = await responsePort.first;

    ResultController resultController = Get.put(ResultController());
    resultController.tempCounts = RxList<dynamic>.from(results[1]);
    resultController.tempCounts.assignAll(results[1]);
    // List<dynamic> tempCounts = results[1];

    return results[1];
  }

  // inference still image
  Future<Uint8List> inferenceImage(String imagePath) async {
    var isolateModel = InferenceModel(imagePath, interpreter.address);
    return _inference(isolateModel);
  }

  Future<List<List<double>>> _detectObjects(File imageFile) async {
    final image = img.decodeImage(await imageFile.readAsBytes());
    if (image == null) {
      log('Failed to decode image.');
      return [];
    }

    log('Image decoded successfully: ${image.width}x${image.height}');

    final imageMatrix = List.generate(
        image.height,
        (y) => List.generate(image.width, (x) {
              final pixel = image.getPixel(x, y);
              final r = img.getRed(pixel);
              final g = img.getGreen(pixel);
              final b = img.getBlue(pixel);
              return [r, g, b];
            }));

    final input = [imageMatrix];

    log("Input is : $input");

    log("Starting output ...");
    final output = {
      0: [List<num>.filled(500, 0)],
      1: [List<List<num>>.filled(500, List<num>.filled(4, 0))],
      2: [0.0],
      3: [List<num>.filled(500, 0)],
    };

    log('Output shape: ${output.values.map((v) => v.length).toList()}');

    try {
      interpreter.run(input, output);
    } catch (e) {
      log('Error during inference: $e');
      return [];
    }

    final results = await isolateInference.getres();
    // log("The result is : $results");
    return results;
  }

  @override
  void dispose() {
    interpreter.close();
    isolateInference.close();
    super.dispose();
  }
}

class ResultController extends GetxController {
  var tempCounts = <dynamic>[].obs; // RxList<dynamic>

  void updateCounts(List<dynamic> counts) {
    tempCounts.assignAll(counts); // Assign the new values
  }
}
