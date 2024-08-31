/*
 * Copyright 2023 The TensorFlow Authors. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *             http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import 'dart:developer';
import 'dart:io';

import 'package:image/image.dart' as img;
import 'package:tflite_flutter/tflite_flutter.dart';

import 'imagedisplay/model/counter_model.dart';

class ObjectDetection {
  static const String _modelPath = 'assets/rebar_counter.tflite';

  //static const String _labelPath = 'assets/models/labelmap.txt';

  Interpreter? _interpreter;
  List<String>? _labels;

  ObjectDetection() {
    _loadModel();
    //_loadLabels();
    log('Done.');
  }

  Future<void> _loadModel() async {
    log('Loading interpreter options...');
    final interpreterOptions = InterpreterOptions();

    // Use XNNPACK Delegate
    if (Platform.isAndroid) {
      interpreterOptions.addDelegate(XNNPackDelegate());
    }

    // Use Metal Delegate
    if (Platform.isIOS) {
      interpreterOptions.addDelegate(GpuDelegate());
    }

    log('Loading interpreter...');
    _interpreter =
        await Interpreter.fromAsset(_modelPath, options: interpreterOptions);
  }

/*  Future<void> _loadLabels() async {
    log('Loading labels...');
    final labelsRaw = await rootBundle.loadString(_labelPath);
    _labels = labelsRaw.split('\n');
  }*/

  List<ObjectCounterModel> analyseImage(String imagePath) {
    log('Analysing image...');
    // Reading image bytes from file
    final imageData = File(imagePath).readAsBytesSync();

    // Decoding image
    final image = img.decodeImage(imageData);

    // Resizing image fpr model, [300, 300]
    final imageInput = img.copyResize(
      image!,
      width: 640,
      height: 640,
    );

    // Creating matrix representation, [300, 300, 3]
    final imageMatrix = List.generate(
      imageInput.height,
      (y) => List.generate(
        imageInput.width,
        (x) {
          final pixel = imageInput.getPixel(x, y);
          final r = img.getRed(pixel);
          final g = img.getGreen(pixel);
          final b = img.getBlue(pixel);
          return [r, g, b];
        },
      ),
    );

    final output = _runInference(imageMatrix);

    log('Processing outputs...$output');

    // Scores
    final scores = output.elementAt(0).first as List<double>;
    log('Scores: $scores');

    // Location
    final locationsRaw = output.elementAt(1).first as List<List<double>>;
    final locations = locationsRaw.map((list) {
      return list.map((value) => (value * 640).toInt()).toList();
    }).toList();
    log('Locations: $locations');

    // Number of detections
    final numberOfDetectionsRaw = output.elementAt(2).first as double;
    final numberOfDetections = numberOfDetectionsRaw.toInt();
    log('Number of detections: $numberOfDetections');

    // Classes
    final classesRaw = output.last.first as List<double>;
    final classes = classesRaw.map((value) => value.toInt()).toList();
    log('Classes: $classes');

    log('Classifying detected objects...');
    // final List<String> classication = [];
    // for (var i = 0; i < numberOfDetections; i++) {
    //   classication.add(_labels![classes[i]]);
    // }

    log('Outlining objects...');
    print(
        "Score with >0.6 length : ${scores.where((element) => element > 0.3).toList().length}");
    List<ObjectCounterModel> objectCounts = [];
    for (var i = 0; i < numberOfDetections; i++) {
      if (scores[i] > 0.3) {
        // Rectangle drawing

/*        img.drawRect(
          imageInput,
          x1: locations[i][1],
          y1: locations[i][0],
          x2: locations[i][3],
          y2: locations[i][2],
          color: img.ColorRgb8(139, 210, 250),
          thickness: 3,
        );*/
        int x1 = locations[i][1];
        int y1 = locations[i][0];
        int x2 = locations[i][3];
        int y2 = locations[i][2];
        int centerX = (x1 + x2) ~/ 2;
        int centerY = (y1 + y2) ~/ 2;
        //int radius = math.sqrt((x2 - x1) ^ 2 + (y2 - y1) ^ 2) ~/ 2;
        int radius = centerY - y1;
        print("Radius value is $radius");
        objectCounts.add(ObjectCounterModel(
            centerX: centerX, centerY: centerY, radius: radius));
/*        img.drawCircle(imageInput,
            x: centerX,
            y: centerY,
            radius: radius,
            color: img.ColorRgb8(139, 210, 250));
        // Label drawing
        img.drawString(
          imageInput,
          '$i',
          font: img.arial24,
          x: centerX - 10,
          y: centerY - 10,
          color: img.ColorRgb8(255, 255, 255),
        );*/
      }
    }

    log('Done.');

    return objectCounts; //img.encodeJpg(imageInput);
  }

  List<List<Object>> _runInference(
    List<List<List<num>>> imageMatrix,
  ) {
    log('Running inference...');

    // Set input tensor [1, 300, 300, 3]
    final input = [imageMatrix];

    // Set output tensor
    // Locations: [1, 10, 4]
    // Classes: [1, 10],
    // Scores: [1, 10],
    // Number of detections: [1]
/*    final output = {
      0: [List<List<num>>.filled(10, List<num>.filled(4, 0))],
      1: [List<num>.filled(10, 0)],
      2: [List<num>.filled(10, 0)],
      3: [0.0],
    };*/
    // output tensor
    // score
    //location
    // number of detections
    // category
    final output = {
      0: [List<num>.filled(500, 0)],
      1: [List<List<num>>.filled(500, List<num>.filled(4, 0))],
      2: [0.0],
      3: [List<num>.filled(500, 0)],
      //3: [0.0],
    };

    _interpreter!.runForMultipleInputs([input], output);
    return output.values.toList();
  }
}
