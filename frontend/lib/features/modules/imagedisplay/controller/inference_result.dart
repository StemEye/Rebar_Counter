import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'package:image/image.dart' as image_lib;
import 'package:rebar_counter/features/modules/imagedisplay/model/counter_model.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class IsolateInference {
  static const String _debugName = "TFLITE_INFERENCE";
  final ReceivePort _receivePort = ReceivePort();
  late Isolate _isolate;
  late SendPort _sendPort;

  SendPort get sendPort => _sendPort;

  Future<void> start() async {
    _isolate = await Isolate.spawn<SendPort>(entryPoint, _receivePort.sendPort,
        debugName: _debugName);
    _sendPort = await _receivePort.first;

    if (_sendPort == null) {
      log('SendPort initialization failed');

      throw StateError('Failed to initialize SendPort');
    }
  }

  Future<void> sendInput(InferenceModel model) async {
    if (_sendPort == null) {
      throw StateError('SendPort is not initialized');
    }
    final responsePort = ReceivePort();
    _sendPort.send([model, responsePort.sendPort]);
    await responsePort.first;
  }

  Future<List<List<double>>> getResults() async {
    final responsePort = ReceivePort();
    _sendPort.send(["getResults", responsePort.sendPort]);
    return await responsePort.first;
  }

  Future<void> close() async {
    _isolate.kill();
    _receivePort.close();
  }

  static void entryPoint(SendPort sendPort) async {
    final port = ReceivePort();
    sendPort.send(port.sendPort);

    await for (final message in port) {
      if (message is List && message.length == 2) {
        final InferenceModel isolateModel = message[0] as InferenceModel;
        String? imagePath = isolateModel.imagePath;

        if (imagePath == null) {
          log('Image path is null.');
          continue;
        }

        final imageData = File(imagePath).readAsBytesSync();
        final img = image_lib.decodeImage(imageData);
        if (img == null) {
          log('Failed to decode image');
          continue;
        }

        final imageInput = image_lib.copyResize(img, width: 512, height: 512);

        final imageMatrix = List.generate(
          imageInput.height,
          (y) => List.generate(
            imageInput.width,
            (x) {
              final pixel = imageInput.getPixel(x, y);
              final r = image_lib.getRed(pixel);
              final g = image_lib.getGreen(pixel);
              final b = image_lib.getBlue(pixel);
              return [r.toDouble(), g.toDouble(), b.toDouble()];
            },
          ),
        );

        final input = [imageMatrix];
        final output = {
          0: [List<num>.filled(500, 0)],
          1: [List<List<num>>.filled(500, List<num>.filled(4, 0))],
          2: [0.0],
          3: [List<num>.filled(500, 0)],
        };

        Interpreter interpreter =
            Interpreter.fromAddress(isolateModel.interpreterAddress);
        interpreter.runForMultipleInputs([input], output);

        final output2 = output.values.toList();
        final scores = output2.elementAt(0).first as List<double>;
        final locationsRaw = output2.elementAt(1).first as List<List<double>>;
        final locations = locationsRaw.map((list) {
          return list.map((value) => (value * 640).toInt()).toList();
        }).toList();

        // Number of detections
        final numberOfDetectionsRaw = output2.elementAt(2).first as double;
        final numberOfDetections = numberOfDetectionsRaw.toInt();
        log('Number of detections: $numberOfDetections');
        // Classes
        final classesRaw = output2.last.first as List<double>;
        final classes = classesRaw.map((value) => value.toInt()).toList();
        log('Classes: $classes');

        List<ObjectCounterModel> objectCounts = [];
        for (var i = 0; i < numberOfDetections; i++) {
          if (scores[i] > 0.3) {
            int x1 = locations[i][1];
            int y1 = locations[i][0];
            int x2 = locations[i][3];

            int y2 = locations[i][2];
            int centerX = (x1 + x2) ~/ 2;
            int centerY = (y1 + y2) ~/ 2;
            int radius = centerY - y1;
            objectCounts.add(ObjectCounterModel(
                centerX: centerX, centerY: centerY, radius: radius));
          }
        }

        isolateModel.responsePort
            .send([image_lib.encodePng(imageInput), objectCounts]);
      }
    }
  }
}

class InferenceModel {
  String? imagePath;
  int interpreterAddress;
  late SendPort responsePort;

  InferenceModel(this.imagePath, this.interpreterAddress);
}
