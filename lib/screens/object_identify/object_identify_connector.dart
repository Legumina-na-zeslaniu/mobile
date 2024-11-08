import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/store/app_state.dart';

class ObjectIdentifyConnector {
  final XFile selectedInventoryTypeImage;

  ObjectIdentifyConnector({required this.selectedInventoryTypeImage});

  static fromStore(Store<AppState> store) {
    return ObjectIdentifyConnector(
      selectedInventoryTypeImage: store.state.selectedInventoryTypeImage!,
    );
  }
}
