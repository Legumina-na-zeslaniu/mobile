import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/utils/types/function.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
import 'package:junction_frame/widgets/buttons.dart';
import 'package:junction_frame/widgets/input_item.dart';
import 'package:junction_frame/widgets/summary_widget/summary_widget_connector.dart';

class SummaryWidget extends StatefulWidget {
  final Funct goFurtherAction;

  const SummaryWidget({super.key, required this.goFurtherAction});

  @override
  State<SummaryWidget> createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {
  bool isEditing = false;

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

  Widget renderBottomContainer() {
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
            LightButton(
              title: 'Change',
              onPress: () => setState(
                () {
                  isEditing = !isEditing;
                },
              ),
              height: 50,
            ),
            InversedButton(
                title: "Next",
                height: 50,
                onPress: () => widget.goFurtherAction())
          ]),
        )
      ],
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
    return StoreConnector<AppState, SummaryWidgetConnector>(
      converter: (store) => SummaryWidgetConnector.fromStore(store),
      builder: (BuildContext context, SummaryWidgetConnector connector) =>
          Scaffold(
              body: SafeArea(
        bottom: false,
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(children: [
                      renderInputContent(context, isEditing),
                      const SizedBox(
                        height: 20,
                      ),
                      renderAddedPictures(connector.images),
                      const SizedBox(
                        height: 180,
                      )
                    ])),
              ),
              renderBottomContainer(),
            ],
          ),
        ),
      )),
    );
  }
}
