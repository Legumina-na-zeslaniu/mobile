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

class ImageVerifier extends StatelessWidget {
  final bool allowRevalidation;
  final String namedPath;
  const ImageVerifier(
      {super.key, this.allowRevalidation = false, required this.namedPath});

  @override
  Widget build(BuildContext context) {
    Widget renderImage(XFile selectedFiele) {
      return Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Image.file(File(selectedFiele.path), fit: BoxFit.cover, width: 250),
          const SizedBox(height: 24),
          Text(selectedFiele.name)
        ]),
      );
    }

    void pickImages(
        Function(List<XFile>) onImagesPicked, BuildContext context) async {
      await CustomImagePicker.pickImages(onImagesPicked).then((value) {
        context.goNamed(namedPath);
      });
    }

    Widget renderBottomContainer(
        Function(List<XFile>, BuildContext) onImagesSelected) {
      return BottomContainer(
        children: [
          const Text('If you want to upload this photo to identify and',
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 10,
          ),
          const Text(' object choose “Next”. ',
              textAlign: TextAlign.center,
              softWrap: true,
              style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(
            height: 10,
          ),
          const Text('If not click “Back” and take a new picture.',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w300)),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  LightButton(
                    title: 'Back',
                    onPress: () => print('Go Back'),
                    height: 50,
                  ),
                  if (allowRevalidation)
                    LightButton(
                      borderRadius: 40,
                      title: '+',
                      onPress: () => pickImages(
                          (files) => onImagesSelected(files, context), context),
                      height: 50,
                      width: 50,
                    ),
                  InversedButton(
                      title: "Next",
                      height: 50,
                      onPress: () => context.goNamed(namedPath))
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
            renderBottomContainer(connector.onMultiImagesSelect),
            renderImage(connector.selectedInventoryTypeImage),
          ],
        ),
      )),
    );
  }
}
