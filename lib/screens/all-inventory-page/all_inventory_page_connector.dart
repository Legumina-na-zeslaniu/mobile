import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/actions/select_inventory_actions.dart';
import 'package:junction_frame/store/app_state.dart';

class AllInventoryPageConnector {
  final List<Inventory> inventoryList;
  final Function(Inventory, Function()) selectInventory;

  AllInventoryPageConnector(
      {required this.inventoryList, required this.selectInventory});

  static AllInventoryPageConnector fromStore(Store<AppState> store) {
    return AllInventoryPageConnector(
        inventoryList: store.state.inventoryList!,
        selectInventory: (Inventory inventory, Function() callback) {
          store
              .dispatchAndWait(SelectInventoryActions(inventory: inventory))
              .then((_) => callback());
        });
  }
}
