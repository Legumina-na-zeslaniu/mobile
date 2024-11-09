import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/screens/api/inventory.dart';
import 'package:junction_frame/store/app_state.dart';

class SummaryWidgetConnector {
  final Inventory inventory;
  final List<XFile> images;

  SummaryWidgetConnector({required this.inventory, required this.images});

  static SummaryWidgetConnector fromStore(Store<AppState> store) {
    return SummaryWidgetConnector(
        inventory: store.state.selectedInventory,
        images: store.state.selectedInventoryTypeImages);
  }
}
