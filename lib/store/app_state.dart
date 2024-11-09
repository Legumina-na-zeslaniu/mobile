import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junction_frame/api/schemas/inventory.dart';

class AppState {
  final List<XFile> selectedInventoryTypeImages;
  final Inventory selectedInventory;

  AppState(
      {required this.selectedInventoryTypeImages,
      required this.selectedInventory});

  static AppState initial() {
    return AppState(
        selectedInventoryTypeImages: [],
        selectedInventory: Inventory(
            name: 'Fire Extenguisher',
            type: 'Health and safety',
            materialType: 'Metal',
            condition: 'Good',
            size: 'Huge boi'));
  }

  AppState copyWith(
      {List<XFile>? selectedInventoryTypeImage, Inventory? selectedInventory}) {
    return AppState(
        selectedInventory: selectedInventory ?? this.selectedInventory,
        selectedInventoryTypeImages:
            selectedInventoryTypeImage ?? this.selectedInventoryTypeImages);
  }
}

Store<AppState> store = Store<AppState>(initialState: AppState.initial());
ImagePicker imagePicker = ImagePicker();
