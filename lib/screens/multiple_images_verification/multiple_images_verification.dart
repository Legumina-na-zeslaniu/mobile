import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:junction_frame/screens/multiple_images_verification/mulitple_images_verification_connector.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/themes/colors.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
import 'package:junction_frame/widgets/input_item.dart';

class MultipleImagesVerification extends StatefulWidget {
  const MultipleImagesVerification({super.key});

  @override
  State<MultipleImagesVerification> createState() =>
      _MultipleImagesVerificationState();
}

class _MultipleImagesVerificationState
    extends State<MultipleImagesVerification> {
  bool isEditing = false;
  bool isAddCommentTriggered = false;

  Widget renderInputContent(BuildContext context, bool isEditing) {
    var items = [
      InputItem(
        title: 'Equipment name',
        value: 'Enter equipment name',
        isEditing: isEditing,
      ),
      SizedBox(
        height: 15,
      ),
      InputItem(
        title: 'Equipment type',
        value: 'Health and safety',
        isEditing: isEditing,
      ),
      SizedBox(
        height: 15,
      ),
      InputItem(
        title: 'Material type',
        value: 'Metal',
        isEditing: isEditing,
      ),
      SizedBox(
        height: 15,
      ),
      InputItem(
        title: 'Condition',
        value: 'Good',
        isEditing: isEditing,
      ),
      SizedBox(
        height: 15,
      ),
      InputItem(
        title: 'Size',
        value: 'Huge boi',
        isEditing: isEditing,
      ),
      SizedBox(
        height: 15,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: kElevationToShadow[4],
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Column(
        children: items,
      ),
    );
  }

  Widget renderBottomContainer(Function() goNextCallback) {
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
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: CustomColors.orange, width: 2)),
              child: RawMaterialButton(
                fillColor: Colors.white,
                onPressed: () => setState(
                  () {
                    isEditing = !isEditing;
                  },
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: const Text('Change',
                    style: TextStyle(color: CustomColors.orange)),
              ),
            ),
            SizedBox(
              height: 50,
              child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor: CustomColors.orange,
                  onPressed: () => goNextCallback(),
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

  Widget renderCommentAddArea() {
    if (!isAddCommentTriggered) {
      return SizedBox(
          height: 50,
          width: double.infinity,
          child: RawMaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              fillColor: CustomColors.orange,
              onPressed: () => setState(() {
                    isAddCommentTriggered = !isAddCommentTriggered;
                  }),
              child: const Text(
                'Add Comment',
                style: TextStyle(color: Colors.white),
              )));
    }
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: kElevationToShadow[4],
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: const InputItem(
        isMultiline: true,
        title: 'Comment',
        isEditing: true,
        value:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      ),
    );
  }

  Widget renderAddedPictures(List<XFile> images) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: kElevationToShadow[4],
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Column(children: [
          const Text('Added pictures'),
          GridView.extent(maxCrossAxisExtent: 200, shrinkWrap: true, children: [
            ...images.map((image) => Image.file(File(image.path)))
          ]),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MulitpleImagesVerificationConnector>(
      converter: (store) =>
          MulitpleImagesVerificationConnector.fromStore(store),
      builder: (BuildContext context,
              MulitpleImagesVerificationConnector connector) =>
          Scaffold(
              body: SafeArea(
        bottom: false,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(children: [
                      renderInputContent(context, isEditing),
                      const SizedBox(
                        height: 20,
                      ),
                      renderAddedPictures(connector.images),
                      const SizedBox(
                        height: 20,
                      ),
                      renderCommentAddArea(),
                      const SizedBox(
                        height: 180,
                      ),
                    ])),
              ),
              renderBottomContainer(() {
                // context.goNamed('place-selection'); TODO fix
              }),
            ],
          ),
        ),
      )),
    );
  }
}
