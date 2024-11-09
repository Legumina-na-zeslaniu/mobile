import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/app_state.dart';

class RemovePropertyAction extends ReduxAction<AppState> {
  final int index;

  RemovePropertyAction({required this.index});

  @override
  AppState reduce() {
    var inventory = state.selectedInventory;

    inventory!.properties?.removeAt(index);

    return state.copyWith(selectedInventory: inventory);
  }
}

class UpdateProperties extends ReduxAction<AppState> {
  final List<Properties> properties;

  UpdateProperties({required this.properties});

  @override
  AppState reduce() {
    var inventory = state.selectedInventory;

    inventory!.properties!.removeWhere((_) => true);

    inventory.properties!.addAll(properties);

    return state.copyWith(selectedInventory: inventory);
  }
}
