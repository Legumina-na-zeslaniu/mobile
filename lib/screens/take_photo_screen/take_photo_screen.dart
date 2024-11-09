import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junction_frame/widgets/custom_image_picker.dart';

class TakePhotoScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Function(XFile) onImageSubmitted;

  const TakePhotoScreen(
      {super.key, required this.cameras, required this.onImageSubmitted});

  @override
  State<TakePhotoScreen> createState() => _TakePhotoScreenState();
}

class _TakePhotoScreenState extends State<TakePhotoScreen> {
  CameraController? _cameraController;
  bool _isRearCameraSelected = true;

  @override
  void initState() {
    super.initState();
    if (widget.cameras.isNotEmpty) {
      initCamera(widget.cameras.first);
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

  Future<void> takePicture() async {
    if (_cameraController == null ||
        !_cameraController!.value.isInitialized ||
        _cameraController!.value.isTakingPicture) {
      return;
    }

    try {
      await _cameraController!.setFlashMode(FlashMode.off);
      final picture = await _cameraController!.takePicture();

      widget.onImageSubmitted(picture);
    } catch (e) {
      debugPrint('Error while taking picture: $e');
    }
  }

  void pickImage(Function(XFile) onImagePicked) async {
    await CustomImagePicker.pickImage((file) => widget.onImageSubmitted(file));
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.cameras.isEmpty) {
      pickImage((img) => widget.onImageSubmitted(img));
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
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
                        setState(() {
                          _isRearCameraSelected = !_isRearCameraSelected;
                          initCamera(
                              widget.cameras[_isRearCameraSelected ? 0 : 1]);
                        });
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
  }
}
