import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/screens/api/inventory.dart';
import 'package:junction_frame/store/app_state.dart';

class MulitpleImagesVerificationConnector {
  final Inventory inventory;
  final List<XFile> images;

  MulitpleImagesVerificationConnector(
      {required this.inventory, required this.images});

  static MulitpleImagesVerificationConnector fromStore(Store<AppState> store) {
    return MulitpleImagesVerificationConnector(
        inventory: store.state.selectedInventory,
        images: store.state.selectedInventoryTypeImages);
  }
}
