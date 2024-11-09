import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:junction_frame/api/schemas/inventory.dart';

enum DataLoadState { loading, loaded, loadRequest, processed, initial }

class AppState {
  final XFile? mainInventoryImage;
  final XFile? additionalInformationImage;
  final Inventory? selectedInventory;
  final DataLoadState? dataLoadState;
  final String? selectedBuildingId;
  final List<Inventory>? inventoryList;

  AppState(
      {this.selectedInventory,
      this.inventoryList,
      this.dataLoadState,
      this.selectedBuildingId,
      this.additionalInformationImage,
      this.mainInventoryImage});

  static AppState initial() {
    return AppState(
      inventoryList: [],
      dataLoadState: DataLoadState.initial,
    );
  }

  AppState copyWith(
      {Inventory? selectedInventory,
      final XFile? mainInventoryImage,
      final String? selectedBuildingId,
      final List<Inventory>? inventoryList,
      final XFile? additionalInformationImage,
      DataLoadState? dataLoadState}) {
    return AppState(
        selectedBuildingId: selectedBuildingId ?? this.selectedBuildingId,
        dataLoadState: dataLoadState ?? this.dataLoadState,
        inventoryList: inventoryList ?? this.inventoryList,
        selectedInventory: selectedInventory ?? this.selectedInventory,
        mainInventoryImage: mainInventoryImage ?? this.mainInventoryImage,
        additionalInformationImage:
            additionalInformationImage ?? this.additionalInformationImage);
  }
}

Store<AppState> store = Store<AppState>(initialState: AppState.initial());
ImagePicker imagePicker = ImagePicker();
