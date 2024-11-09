import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/store/actions/upload_images_action.dart';
import 'package:junction_frame/store/actions/upsert_images_action.dart';
import 'package:junction_frame/store/app_state.dart';

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
            .dispatchAndWait(UpsertImagesAction(
                additionalInformationData:
                    store.state.additionalInformationImage!))
            .then((value) => {callback.call()}));
  }
}
