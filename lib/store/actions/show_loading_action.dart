import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/store/app_state.dart';

class ShowLoadingAction extends ReduxAction<AppState> {
  final DataLoadState dataLoadState;

  ShowLoadingAction({required this.dataLoadState});

  @override
  AppState reduce() {
    return store.state.copyWith(dataLoadState: dataLoadState);
  }
}
