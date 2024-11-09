// ignore_for_file: use_build_context_synchronously

import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/store/actions/selec_iInventory_type_action.dart';
import 'package:junction_frame/store/app_state.dart';

class TakeMultipleImagesScreenConnector {
  final Function(XFile) onDataSelected;

  TakeMultipleImagesScreenConnector({required this.onDataSelected});

  static TakeMultipleImagesScreenConnector fromStore(Store<AppState> store) {
    return TakeMultipleImagesScreenConnector(onDataSelected: (data) {
      store.dispatchAndWait(SelectInventoryTypeAction(data: [data]));
    });
  }
}
