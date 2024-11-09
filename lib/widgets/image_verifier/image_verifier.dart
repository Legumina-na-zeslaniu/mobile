import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junction_frame/screens/multiple_object_identify/multiple_object_identify_connector.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
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
          const Text(
            'If you want to upload this photo to identify and',
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          const Text(
            ' object choose “Next”. ',
            textAlign: TextAlign.center,
            softWrap: true,
          ),
          const Text(
            'If not click “Back” and take a new picture.',
            textAlign: TextAlign.center,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.orange, width: 2)),
                    child: RawMaterialButton(
                      fillColor: Colors.white,
                      onPressed: () => print('Go back'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text('Back',
                          style: TextStyle(color: Colors.orange)),
                    ),
                  ),
                  if (allowRevalidation)
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.orange, width: 2)),
                      child: RawMaterialButton(
                        fillColor: Colors.white,
                        onPressed: () => pickImages(
                            (files) => onImagesSelected(files, context),
                            context),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        child: const Text('+',
                            style: TextStyle(color: Colors.orange)),
                      ),
                    ),
                  SizedBox(
                    height: 50,
                    child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fillColor: Colors.orange,
                        onPressed: () => context.goNamed(namedPath),
                        child: const Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
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
