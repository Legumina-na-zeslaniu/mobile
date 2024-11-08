// ignore_for_file: use_build_context_synchronously

import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/store/actions/selec_iInventory_type_action.dart';
import 'package:junction_frame/store/app_state.dart';

class TakePhotoScreenConnector {
  final Function(XFile file, BuildContext context) onDataSelected;

  TakePhotoScreenConnector({required this.onDataSelected});

  static TakePhotoScreenConnector fromStore(Store<AppState> store) {
    return TakePhotoScreenConnector(onDataSelected: (data, context) {
      store
          .dispatchAndWait(SelectInventoryTypeAction(data: data))
          .then((value) => context.goNamed('object-identify'));
    });
  }
}
