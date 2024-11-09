import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/navigation/routing.dart';
import 'package:junction_frame/screens/accept_inventory_type/accept_inventory_type_connector.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/bottom_container.dart';

class InputItem extends StatelessWidget {
  final String title;
  final String value;
  final bool isEditing;

  const InputItem(
      {super.key,
      required this.title,
      required this.value,
      this.isEditing = false});

  @override
  Widget build(BuildContext context) {
    var controller = TextEditingController(text: value);

    return Column(children: [
      Text(title),
      TextField(
        controller: controller,
        enabled: isEditing,
        decoration: const InputDecoration(
            labelText: '',
            hintText: '',
            border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      )
    ]);
  }
}

class AcceptInventoryType extends StatefulWidget {
  const AcceptInventoryType({super.key});

  @override
  State<AcceptInventoryType> createState() => _AcceptInventoryTypeState();
}

class _AcceptInventoryTypeState extends State<AcceptInventoryType> {
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
            Container(
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.orange, width: 2)),
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
                    style: TextStyle(color: Colors.orange)),
              ),
            ),
            SizedBox(
              height: 50,
              child: RawMaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fillColor: Colors.orange,
                  onPressed: () async {
                    await availableCameras().then((value) => context.goNamed(
                          'multiple-images',
                          extra: value,
                        ));
                  },
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
    return StoreConnector<AppState, AcceptInventoryTypeConnector>(
      converter: (store) => AcceptInventoryTypeConnector.fromStore(store),
      builder: (BuildContext context, AcceptInventoryTypeConnector connector) =>
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
