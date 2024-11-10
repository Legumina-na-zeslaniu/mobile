import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/app_state.dart';

class SelectInventoryActions extends ReduxAction<AppState> {
  final Inventory inventory;

  SelectInventoryActions({required this.inventory});

  @override
  AppState reduce() {
    return store.state.copyWith(selectedInventory: inventory);
  }
}
