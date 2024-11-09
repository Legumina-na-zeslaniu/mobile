import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/screens/api/inventory.dart';
import 'package:junction_frame/store/app_state.dart';

class AcceptInventoryTypeConnector {
  final Inventory inventory;
  final List<XFile> images;

  AcceptInventoryTypeConnector({required this.inventory, required this.images});

  static AcceptInventoryTypeConnector fromStore(Store<AppState> store) {
    return AcceptInventoryTypeConnector(
        inventory: store.state.selectedInventory,
        images: store.state.selectedInventoryTypeImages);
  }
}
