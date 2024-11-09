import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/store/app_state.dart';

class SelectBuildingAction extends ReduxAction<AppState> {
  final String buildingId;

  SelectBuildingAction({required this.buildingId});

  @override
  AppState reduce() {
    return state.copyWith(selectedBuildingId: buildingId);
  }
}
