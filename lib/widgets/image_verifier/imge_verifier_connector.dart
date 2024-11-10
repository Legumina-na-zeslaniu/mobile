import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/store/app_state.dart';

class ImageVerifierConnector {
  final XFile selectedInventoryTypeImage;

  ImageVerifierConnector({
    required this.selectedInventoryTypeImage,
  });

  static fromStore(Store<AppState> store) {
    return ImageVerifierConnector(
        selectedInventoryTypeImage: store.state.additionalInformationImage ??
            store.state.mainInventoryImage!);
  }
}
