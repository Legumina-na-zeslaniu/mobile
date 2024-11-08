import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';

class AppState {
  final XFile? selectedInventoryTypeImage;

  AppState({this.selectedInventoryTypeImage});

  static AppState initial() {
    return AppState(
      selectedInventoryTypeImage: null,
    );
  }

  AppState copyWith({XFile? selectedInventoryTypeImage}) {
    return AppState(
        selectedInventoryTypeImage:
            selectedInventoryTypeImage ?? this.selectedInventoryTypeImage);
  }
}

Store<AppState> store = Store<AppState>(initialState: AppState());
