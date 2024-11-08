import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/screens/api/inventory.dart';
import 'package:junction_frame/store/app_state.dart';

class AcceptInventoryTypeConnector {
  final Inventory inventory;

  AcceptInventoryTypeConnector({required this.inventory});

  static AcceptInventoryTypeConnector fromStore(Store<AppState> store) {
    return AcceptInventoryTypeConnector(
      inventory: store.state.selectedInventory!,
    );
  }
}
