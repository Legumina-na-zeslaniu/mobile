import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/store/app_state.dart';

class SelectInventoryImageAction extends ReduxAction<AppState> {
  final XFile file;

  SelectInventoryImageAction({required this.file});

  @override
  AppState reduce() {
    return store.state.copyWith(mainInventoryImage: file);
  }
}

class SelectAdditionalInformationImageAction extends ReduxAction<AppState> {
  final XFile file;

  SelectAdditionalInformationImageAction({required this.file});

  @override
  AppState reduce() {
    return store.state.copyWith(additionalInformationImage: file);
  }
}
