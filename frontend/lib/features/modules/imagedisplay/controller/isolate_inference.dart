import 'dart:developer';
import 'dart:io';
import 'dart:isolate';

import 'package:image/image.dart' as image_lib;
import 'package:rebar_counter/features/modules/imagedisplay/model/counter_model.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

// assignToVar(List<ObjectCounterModel> objectCounts) {
//   ResultController resultController = Get.put(ResultController());
//   resultController.counts = objectCounts;
// }

// List<ObjectCounterModel> objectsCounts = [];

class IsolateInference {
  static const String _debugName = "TFLITE_INFERENCE";
  final ReceivePort _receivePort = ReceivePort();
  late Isolate _isolate;
  late SendPort _sendPort;

  // List<ObjectCounterModel> objectsCounts = [];

  SendPort get sendPort => _sendPort;

  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(entryPoint, _receivePort.sendPort,
        debugName: _debugName);
    _sendPort = await _receivePort.first;
  }

  Future<void> close() async {
    _isolate.kill();
    _receivePort.close();
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final InferenceModel isolateModel in port) {
      final imagePath = isolateModel.imagePath!;
      final imageData = File(imagePath).readAsBytesSync();
      final img = image_lib.decodeImage(imageData);

      if (img == null) {
        log('Failed to decode image.');
        continue;
      }

      // Resizing image fpr model, [640, 640]
      final imageInput = image_lib.copyResize(
        img,
        width: 640,
        height: 640,
      );

      // Creating matrix representation, [640, 640, 3]
      final imageMatrix = List.generate(
        imageInput.height,
        (y) => List.generate(
          imageInput.width,
          (x) {
            final pixel = imageInput.getPixel(x, y);
            final r = image_lib.getRed(pixel) / 255.0;
            final g = image_lib.getGreen(pixel) / 255.0;
            final b = image_lib.getBlue(pixel) / 255.0;
            return [r, g, b];
          },
        ),
      );

      // Set tensor input [1, 224, 224, 3]
      final input = [imageMatrix];
      // Set tensor output [1, 1001]
      final output = {
        0: [List<num>.filled(500, 0)],
        1: [List<List<num>>.filled(500, List<num>.filled(4, 0))],
        2: [0.0],
        3: [List<num>.filled(500, 0)],
      };
      // // Run inference
      Interpreter interpreter =
          Interpreter.fromAddress(isolateModel.interpreterAddress);
      //print("****** $interpreter | | input $input");
      try {
        interpreter.runForMultipleInputs([input], output);
      } catch (e) {
        log('Inference failed: $e');
        continue;
      }

      //log('Processing outputs...$output');
      final outputList = output.values.toList();
      // Scores
      final scores = outputList[0].first as List<double>;
      //log('Scores: $scores');

      // Location
      final locationsRaw = outputList[1].first as List<List<double>>;
      final numberOfDetections = (outputList[2].first as double).toInt();
      final classes =
          (outputList[3].first as List<double>).map((v) => v.toInt()).toList();

      //log('Locations: $locations');
      log('Scores: $scores');
      log('Locations: $locationsRaw');
      log('Number of detections: $numberOfDetections');
      log('Classes: $classes');
      // Number of detections

      List<ObjectCounterModel> objectCounts = [];
      for (var i = 0; i < numberOfDetections; i++) {
        if (scores[i] > 0.3) {
          final loc = locationsRaw[i];
          final x1 = (loc[1] * 640).toInt();
          final y1 = (loc[0] * 640).toInt();
          final x2 = (loc[3] * 640).toInt();
          final y2 = (loc[2] * 640).toInt();
          final centerX = (x1 + x2) ~/ 2;
          final centerY = (y1 + y2) ~/ 2;
          final radius = centerY - y1;
          log("Detected object $i at ($centerX, $centerY) with radius $radius");
          objectCounts.add(ObjectCounterModel(
              centerX: centerX, centerY: centerY, radius: radius));
        }
      }

      log('Detection complete. $objectCounts');
      isolateModel.responsePort
          .send([image_lib.encodePng(imageInput), objectCounts]);
    }
  }

  getres() {}
}
// final numberOfDetectionsRaw = output2.elementAt(2).first as double;
// final numberOfDetections = numberOfDetectionsRaw.toInt();
// log('Number of detections: $numberOfDetections');

// // Classes
// final classesRaw = output2.last.first as List<double>;
// final classes = classesRaw.map((value) => value.toInt()).toList();
// log('Classes: $classes');

// log('Classifying detected objects...');

// log('Outlining objects...');
// // print(
// //     "Score with >0.6 length : ${scores.where((element) => element > 0.3).toList().length}");
// List<ObjectCounterModel> objectCounts = [];
// for (var i = 0; i < numberOfDetections; i++) {
//   if (scores[i] > 0.3) {
//     int x1 = locations[i][1];
//     int y1 = locations[i][0];
//     int x2 = locations[i][3];
//     int y2 = locations[i][2];
//     int centerX = (x1 + x2) ~/ 2;
//     int centerY = (y1 + y2) ~/ 2;
//     int radius = centerY - y1;
//     print("Radius value is $radius");
//     objectCounts.add(ObjectCounterModel(
//         centerX: centerX, centerY: centerY, radius: radius));
// for (int t = 0; t < 4; t++) {
//   image_lib.drawCircle(imageInput,
//       x: centerX,
//       y: centerY,
//       radius: radius - t,
//       color: image_lib.ColorRgb8(139, 210, 250));
// }
// // Label drawing
// image_lib.drawString(
//   imageInput,
//   '${i + 1}',
//   font: image_lib.arial24,
//   x: centerX - '${i + 1}'.length * 8,
//   y: centerY - 12,
//   color: image_lib.ColorRgb8(255, 255, 255),
// );
//         }
//       }

//       log('Done. $objectCounts');
//       isolateModel.responsePort
//           .send([image_lib.encodePng(imageInput), objectCounts]);
//     }
//   }
// }

class InferenceModel {
  String? imagePath;
  int interpreterAddress;
  late SendPort responsePort;

  InferenceModel(this.imagePath, this.interpreterAddress);
}
