import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/navigation/routing.dart';
import 'package:junction_frame/screens/object_identify/object_identify_connector.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/bottom_container.dart';

class ObjectIdentify extends StatelessWidget {
  const ObjectIdentify({super.key});

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
                      onPressed: () => print('aa'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text('Back',
                          style: TextStyle(color: Colors.orange)),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: RawMaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        fillColor: Colors.orange,
                        onPressed: () => context.goNamed('accept-inventory'),
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

    return StoreConnector<AppState, ObjectIdentifyConnector>(
      converter: (store) => ObjectIdentifyConnector.fromStore(store),
      builder: (BuildContext context, ObjectIdentifyConnector connector) =>
          Scaffold(
              body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            renderBottomContainer(),
            renderImage(connector.selectedInventoryTypeImage),
          ],
        ),
      )),
    );
  }
}
