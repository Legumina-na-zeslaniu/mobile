import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/screens/take_photo_screen/take_photo_screen.dart';
import 'package:junction_frame/store/actions/select_images_action.dart';
import 'package:junction_frame/store/app_state.dart';

class InventoryTakePhotoScreen extends StatelessWidget {
  final List<CameraDescription> cameras;
  const InventoryTakePhotoScreen({super.key, required this.cameras});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Connector>(
        converter: (store) => _Connector.fromStore(store),
        builder: (BuildContext context, _Connector vm) {
          return TakePhotoScreen(
            cameras: cameras,
            onImageSubmitted: (file) => {
              vm.onImageSubmit(file, () => context.goNamed('object-identify'))
            },
          );
        });
  }
}

class _Connector {
  final Function(XFile, Function()) onImageSubmit;

  _Connector({required this.onImageSubmit});

  static _Connector fromStore(Store<AppState> store) {
    return _Connector(
        onImageSubmit: (file, callback) => store
            .dispatchAndWait(SelectInventoryImageAction(file: file))
            .then((value) => {callback.call()}));
  }
}
