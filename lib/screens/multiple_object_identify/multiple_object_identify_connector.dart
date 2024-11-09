import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/store/actions/selec_iInventory_type_action.dart';
import 'package:junction_frame/store/app_state.dart';

class MultipleObjectIdentifyConnector {
  final XFile selectedInventoryTypeImage;
  final Function(List<XFile>, BuildContext) onMultiImagesSelect;

  MultipleObjectIdentifyConnector(
      {required this.selectedInventoryTypeImage,
      required this.onMultiImagesSelect});

  static fromStore(Store<AppState> store) {
    return MultipleObjectIdentifyConnector(
        selectedInventoryTypeImage:
            store.state.selectedInventoryTypeImages.last,
        onMultiImagesSelect: (images, context) {
          store
              .dispatchAndWait(SelectInventoryTypeAction(data: images))
              .then((value) {});
        });
  }
}
