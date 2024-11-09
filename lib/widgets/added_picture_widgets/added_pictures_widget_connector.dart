import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/store/app_state.dart';

class AddedPicturesWidgetConnector {
  final List<XFile> images;

  AddedPicturesWidgetConnector({required this.images});

  static AddedPicturesWidgetConnector fromStore(Store<AppState> store) {
    return AddedPicturesWidgetConnector(
        images: store.state.selectedInventoryTypeImages);
  }
}
