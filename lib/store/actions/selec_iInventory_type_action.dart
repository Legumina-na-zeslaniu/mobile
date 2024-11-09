import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/store/app_state.dart';

class SelectInventoryTypeAction extends ReduxAction<AppState> {
  final List<XFile> data;

  SelectInventoryTypeAction({required this.data});

  @override
  AppState reduce() {
    return state.copyWith(
      selectedInventoryTypeImage: [
        ...store.state.selectedInventoryTypeImages,
        ...data
      ],
    );
  }
}
