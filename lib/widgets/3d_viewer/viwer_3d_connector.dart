import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/store/actions/select_building_action.dart';
import 'package:junction_frame/store/app_state.dart';

class Viwer3dConnector {
  final String? selectedBuildingId;
  final Function(String) selectBuildingId;

  Viwer3dConnector(
      {required this.selectedBuildingId, required this.selectBuildingId});

  static Viwer3dConnector fromStore(Store<AppState> store) {
    return Viwer3dConnector(
        selectedBuildingId: store.state.selectedBuildingId,
        selectBuildingId: (buildingId) {
          store.dispatch(SelectBuildingAction(buildingId: buildingId));
        });
  }
}
