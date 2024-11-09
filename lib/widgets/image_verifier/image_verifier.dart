import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
import 'package:junction_frame/widgets/buttons.dart';
import 'package:junction_frame/widgets/custom_image_picker.dart';
import 'package:junction_frame/widgets/image_verifier/imge_verifier_connector.dart';
import 'package:junction_frame/widgets/text_widgets.dart';

// ignore: must_be_immutable
class ImageVerifier extends StatelessWidget {
  final bool allowRevalidation;
  final String namedPath;
  List<Widget>? bottomContainerTexts;
  Function(XFile) onSubmit;

  ImageVerifier(
      {super.key,
      this.allowRevalidation = false,
      required this.namedPath,
      this.bottomContainerTexts,
      required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    Widget renderImage(XFile selectedFiele) {
      return SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(File(selectedFiele.path), fit: BoxFit.cover, width: 250),
        ]),
      );
    }

    void pickImages() async {
      await CustomImagePicker.pickImage((image) => onSubmit(image));
    }

    Widget renderBottomContainer(
        Function() callback, XFile selectedFile, Function() goBackCallback) {
      return BottomContainer(
        children: [
          ...(bottomContainerTexts == null)
              ? TextWidgetsUtils.generateHeaderWithSubHedaer()
              : bottomContainerTexts!,
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LightButton(
                    title: 'Back',
                    onPress: () => goBackCallback(),
                    height: 50,
                  ),
                  if (allowRevalidation)
                    LightButton(
                      borderRadius: 40,
                      title: '+',
                      onPress: () => pickImages(),
                      height: 50,
                      width: 50,
                    ),
                  InversedButton(
                      title: "Next",
                      height: 50,
                      onPress: () => onSubmit(selectedFile))
                ]),
          )
        ],
      );
    }

    return StoreConnector<AppState, ImageVerifierConnector>(
      converter: (store) => ImageVerifierConnector.fromStore(store),
      builder: (BuildContext context, ImageVerifierConnector connector) =>
          Scaffold(
              body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            renderImage(connector.selectedInventoryTypeImage),
            renderBottomContainer(() => context.goNamed(namedPath),
                connector.selectedInventoryTypeImage, () => context.pop()),
          ],
        ),
      )),
    );
  }
}
