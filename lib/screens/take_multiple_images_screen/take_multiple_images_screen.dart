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
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.cameras.isNotEmpty) initCamera(widget.cameras.first);
  }

  Future<void> takePicture() async {
    if (_cameraController?.value.isTakingPicture ?? true) return;

    try {
      await _cameraController!.setFlashMode(FlashMode.off);
      final picture = await _cameraController!.takePicture();
      print(picture);
    } catch (e) {
      debugPrint('Error while taking picture: $e');
    }
  }

  Future<void> initCamera(CameraDescription cameraDescription) async {
    _cameraController =
        CameraController(cameraDescription, ResolutionPreset.high);
    try {
      await _cameraController!.initialize();
      if (mounted) setState(() {});
    } catch (e) {
      debugPrint("Camera initialization error: $e");
    }
  }

  Future<void> pickImage(
      Function(List<XFile>) onImagesPicked, BuildContext context) async {
    await CustomImagePicker.pickImages(onImagesPicked);
    context.goNamed('multiple-object-identify');
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TakeMultipleImagesScreenConnector>(
      converter: (store) => TakeMultipleImagesScreenConnector.fromStore(store),
      builder: (context, modal) {
        if (widget.cameras.isEmpty) {
          pickImage(modal.onDataSelected, context);
          return const SizedBox.shrink();
        }

        return Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                if (_cameraController?.value.isInitialized ?? false)
                  CameraPreview(_cameraController!)
                else
                  const Center(child: CircularProgressIndicator()),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: const BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(24)),
                      color: Colors.black,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          icon: Icon(
                            _isRearCameraSelected
                                ? CupertinoIcons.switch_camera
                                : CupertinoIcons.switch_camera_solid,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() =>
                                _isRearCameraSelected = !_isRearCameraSelected);
                            initCamera(
                                widget.cameras[_isRearCameraSelected ? 0 : 1]);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.circle, color: Colors.white),
                          iconSize: 50,
                          onPressed: takePicture,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
