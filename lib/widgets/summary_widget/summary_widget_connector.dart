import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/actions/remove_property_action.dart';
import 'package:junction_frame/store/app_state.dart';

class SummaryWidgetConnector {
  final Inventory? inventory;
  final List<XFile> images;
  final Function(int) removeProperty;
  final Function(List<Properties>) updateProperties;

  SummaryWidgetConnector(
      {required this.inventory,
      required this.updateProperties,
      required this.images,
      required this.removeProperty});

  static SummaryWidgetConnector fromStore(Store<AppState> store) {
    return SummaryWidgetConnector(
        inventory: store.state.selectedInventory,
        removeProperty: (index) {
          store.dispatch(RemovePropertyAction(index: index));
        },
        updateProperties: (properties) {
          store.dispatch(UpdateProperties(properties: properties));
        },
        images: [
          store.state.additionalInformationImage,
          store.state.mainInventoryImage
        ].where((e) => e != null).map((e) => e as XFile).toList());
  }
}
