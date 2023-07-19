import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app/blocs/ml_kit_bloc.dart';
import 'package:social_media_app/widgets/primary_buttom_view.dart';

class MLKitTextRecognition extends StatelessWidget {
  const MLKitTextRecognition({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MLKitBloc(),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
            Consumer<MLKitBloc>(
              builder: (context, bloc, child) => Visibility(
                  visible: bloc.chosenImageFile != null,
                  child: Image.file(
                    bloc.chosenImageFile ?? File(""),
                    width: 300,
                    height: 300,
                  )),
            ),
            const SizedBox(
              height: 100,
            ),
            Consumer<MLKitBloc>(
                builder: (context, bloc, child) => GestureDetector(
                      onTap: () {
                        ImagePicker()
                            .pickImage(source: ImageSource.gallery)
                            .then((pickImage) async {
                          var bytes = await pickImage?.readAsBytes();
                          bloc.onImageChosen(File(pickImage?.path ?? ""),
                              bytes ?? Uint8List(0));
                        });
                      },
                      child: const PrimaryButtonView(label: "Choose"),
                    ))
          ]),
        ),
      ),
    );
  }
}
