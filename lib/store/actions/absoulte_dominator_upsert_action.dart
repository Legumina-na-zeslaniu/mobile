import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/store/app_state.dart';

class AbsoulteDominatorUpsertAction extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    return state;
  }
}
