import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/screens/api/inventory.dart';

class AppState {
  final XFile? selectedInventoryTypeImage;
  final Inventory selectedInventory;

  AppState({this.selectedInventoryTypeImage, required this.selectedInventory});

  static AppState initial() {
    return AppState(
        selectedInventory: Inventory(
            name: 'Fire Extenguisher',
            type: 'Health and safety',
            materialType: 'Metal',
            condition: 'Good',
            size: 'Huge boi'));
  }

  AppState copyWith(
      {XFile? selectedInventoryTypeImage, Inventory? selectedInventory}) {
    return AppState(
        selectedInventory: selectedInventory ?? this.selectedInventory,
        selectedInventoryTypeImage:
            selectedInventoryTypeImage ?? this.selectedInventoryTypeImage);
  }
}

Store<AppState> store = Store<AppState>(initialState: AppState.initial());
