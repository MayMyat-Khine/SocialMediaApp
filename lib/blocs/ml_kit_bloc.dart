import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:social_media_app/ml_kit/mk_kit_text_recognition.dart';

class MLKitBloc extends ChangeNotifier {
  File? chosenImageFile;
  final MLKitTextRecogniation _mlKitTextRecogniation = MLKitTextRecogniation();
  onImageChosen(File image, Uint8List bytes) {
    chosenImageFile = image;
    _mlKitTextRecogniation.detectText(image);
    notifyListeners();
  }
}
