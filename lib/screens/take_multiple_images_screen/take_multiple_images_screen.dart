import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junction_frame/screens/take_multiple_images_screen/take_multiple_images_screen_connector.dart';
import 'package:junction_frame/screens/take_photo_screen/take_photo_screen_connector.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/custom_image_picker.dart';

class TakeMultipleImagesScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const TakeMultipleImagesScreen({super.key, required this.cameras});

  @override
  State<TakeMultipleImagesScreen> createState() =>
      _TakeMultipleImagesScreenState();
}

class _TakeMultipleImagesScreenState extends State<TakeMultipleImagesScreen> {
  CameraController? _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void dispose() {
    if (_cameraController != null) _cameraController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.cameras.isNotEmpty) {
      initCamera(widget.cameras[0]);
    }
  }

  Future takePicture() async {
    if (!_cameraController!.value.isInitialized) {
      return null;
    }
    if (_cameraController!.value.isTakingPicture) {
      return null;
    }
    try {
      await _cameraController!.setFlashMode(FlashMode.off);
      XFile picture = await _cameraController!.takePicture();
      print(picture);
    } on CameraException catch (e) {
      debugPrint('Error occured while taking picture: $e');
      return null;
    }
  }

  Future initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController!.initialize().then((_) {
        if (!mounted) return;
        setState(() {});
      });
    } on CameraException catch (e) {
      debugPrint("camera error $e");
    }
  }

  void pickImage(Function(XFile) onImagePicked, BuildContext context) async {
    await CustomImagePicker.pickImage(onImagePicked);

    context.goNamed('multiple-object-identify');
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TakeMultipleImagesScreenConnector>(
      converter: (store) => TakeMultipleImagesScreenConnector.fromStore(store),
      builder: (BuildContext context, TakeMultipleImagesScreenConnector modal) {
        if (widget.cameras.isEmpty) {
          pickImage(modal.onDataSelected, context);

          return Container();
        }

        return Scaffold(
            body: SafeArea(
          child: Stack(children: [
            (_cameraController!.value.isInitialized)
                ? CameraPreview(_cameraController!)
                : Container(
                    color: Colors.black,
                    child: const Center(child: CircularProgressIndicator())),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                      color: Colors.black),
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: IconButton(
                          padding: EdgeInsets.zero,
                          iconSize: 30,
                          icon: Icon(
                              _isRearCameraSelected
                                  ? CupertinoIcons.switch_camera
                                  : CupertinoIcons.switch_camera_solid,
                              color: Colors.white),
                          onPressed: () {
                            setState(() =>
                                _isRearCameraSelected = !_isRearCameraSelected);
                            initCamera(
                                widget.cameras![_isRearCameraSelected ? 0 : 1]);
                          },
                        )),
                        Expanded(
                            child: IconButton(
                          onPressed: takePicture,
                          iconSize: 50,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: const Icon(Icons.circle, color: Colors.white),
                        )),
                        const Spacer(),
                      ]),
                )),
          ]),
        ));
      },
    );
  }
}
