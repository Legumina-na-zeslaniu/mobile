import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junction_frame/store/app_state.dart';

class CustomImagePicker {
  static Future<XFile?> pickImage(Function(XFile) onImagePicked) async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      onImagePicked(pickedFile);
      return pickedFile;
    }
    return pickedFile;
  }

  static Future<List<XFile>> pickImages(
      Function(List<XFile>) onImagesPicked) async {
    final List<XFile> pickedFiles = await imagePicker.pickMultiImage();

    if (pickedFiles.isNotEmpty) {
      onImagesPicked(pickedFiles);
      return pickedFiles;
    }
    return pickedFiles;
  }
}
