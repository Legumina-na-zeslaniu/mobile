import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/actions/select_building_action.dart';
import 'package:junction_frame/store/actions/select_localization_action.dart';
import 'package:junction_frame/store/app_state.dart';

class Viwer3dConnector {
  final String? selectedBuildingId;
  final Function(String) selectBuildingId;
  final Function(Localization) selectLocalization;

  Viwer3dConnector(
      {required this.selectedBuildingId,
      required this.selectBuildingId,
      required this.selectLocalization});

  static Viwer3dConnector fromStore(Store<AppState> store) {
    return Viwer3dConnector(
        selectLocalization: (Localization localization) {
          store.dispatch(SelectLocalizationAction(localization: localization));
        },
        selectedBuildingId: store.state.selectedBuildingId,
        selectBuildingId: (buildingId) {
          store.dispatch(SelectBuildingAction(buildingId: buildingId));
        });
  }
}
