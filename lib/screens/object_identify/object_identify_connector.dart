import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/store/actions/upload_images_action.dart';
import 'package:junction_frame/store/app_state.dart';

class ObjectIdentifyConnector {
  final XFile? selectedInventoryTypeImage;
  final Function(XFile, Function()) onSubmit;
  ObjectIdentifyConnector(
      {required this.selectedInventoryTypeImage, required this.onSubmit});

  static fromStore(
    Store<AppState> store,
  ) {
    return ObjectIdentifyConnector(
        selectedInventoryTypeImage: store.state.mainInventoryImage,
        onSubmit: (file, callback) => store
            .dispatchAndWait(UploadImagesAction(file: file))
            .then((value) => {callback.call()}));
  }
}
