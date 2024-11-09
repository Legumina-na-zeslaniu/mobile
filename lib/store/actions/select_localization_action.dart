import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/app_state.dart';

class SelectLocalizationAction extends ReduxAction<AppState> {
  final Localization localization;

  SelectLocalizationAction({required this.localization});

  @override
  AppState reduce() {
    if (state.selectedInventory == null) {
      return state;
    }

    var currentInv = state.selectedInventory!;
    return state.copyWith(
        selectedInventory: Inventory(
            localization: localization,
            comments: currentInv.comments,
            buildingId: currentInv.buildingId,
            properties: currentInv.properties));
  }
}
