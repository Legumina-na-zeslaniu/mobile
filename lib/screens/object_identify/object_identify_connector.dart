import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/navigation/routing.dart';
import 'package:junction_frame/store/actions/selec_iInventory_type_action.dart';
import 'package:junction_frame/store/app_state.dart';

class ObjectIdentifyConnector {
  final XFile? selectedInventoryTypeImage;

  ObjectIdentifyConnector({
    required this.selectedInventoryTypeImage,
  });

  static fromStore(
    Store<AppState> store,
  ) {
    return ObjectIdentifyConnector(
      selectedInventoryTypeImage:
          store.state.selectedInventoryTypeImages.lastOrNull,
    );
  }
}
