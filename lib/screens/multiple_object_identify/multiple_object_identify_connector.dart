import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/store/actions/upload_images_action.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/image_verifier/imge_verifier_connector.dart';

class MultipleObjectIdentifyConnector {
  final XFile? selectedInventoryTypeImage;
  final Function(XFile, Function()) onSubmit;
  MultipleObjectIdentifyConnector(
      {required this.selectedInventoryTypeImage, required this.onSubmit});

  static fromStore(
    Store<AppState> store,
  ) {
    return MultipleObjectIdentifyConnector(
        selectedInventoryTypeImage: store.state.additionalInformationImage,
        onSubmit: (file, callback) => store
            .dispatchAndWait(UploadImagesAction(file: file))
            .then((value) => {callback.call()}));
  }
}
