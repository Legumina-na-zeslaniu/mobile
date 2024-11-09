import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/actions/comment_supplier_action.dart';
import 'package:junction_frame/store/actions/upsert_images_action.dart';
import 'package:junction_frame/store/app_state.dart';

class MulitpleImagesVerificationConnector {
  final Inventory? inventory;
  final XFile? additionalInformationImages;

  MulitpleImagesVerificationConnector(
      {required this.inventory, required this.additionalInformationImages});

  static MulitpleImagesVerificationConnector fromStore(Store<AppState> store) {
    return MulitpleImagesVerificationConnector(
        inventory: store.state.selectedInventory,
        additionalInformationImages: store.state.additionalInformationImage);
  }

  void upsert(String commentValue) {
    store.dispatch(CommentSupplierAction(
      commentValue: commentValue,
    ));
  }
}
