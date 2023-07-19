import 'dart:io';

import 'package:google_ml_kit/google_ml_kit.dart';

class MLKitTextRecogniation {
  static final MLKitTextRecogniation _singleton =
      MLKitTextRecogniation._internal();

  factory MLKitTextRecogniation() {
    return _singleton;
  }

  MLKitTextRecogniation._internal();

  void detectText(File image) async {
    InputImage inputImage = InputImage.fromFile(image);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognizedText =
        await textDetector.processImage(inputImage);
    recognizedText.blocks.forEach((element) {
      print("Text" + element.text);
    });
  }
}
