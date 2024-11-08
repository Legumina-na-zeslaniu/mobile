import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junction_frame/screens/object_identify/object_identify_connector.dart';
import 'package:junction_frame/store/app_state.dart';

class ObjectIdentify extends StatelessWidget {
  const ObjectIdentify({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ObjectIdentifyConnector>(
      converter: (store) => ObjectIdentifyConnector.fromStore(store),
      builder: (BuildContext context, ObjectIdentifyConnector connector) =>
          Scaffold(
        body: Center(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Image.file(File(connector.selectedInventoryTypeImage.path),
                fit: BoxFit.cover, width: 250),
            const SizedBox(height: 24),
            Text(connector.selectedInventoryTypeImage.name)
          ]),
        ),
      ),
    );
  }
}
