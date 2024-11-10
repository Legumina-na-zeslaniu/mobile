import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/actions/absoulte_dominator_upsert_action.dart';
import 'package:junction_frame/store/actions/comment_supplier_action.dart';
import 'package:junction_frame/store/actions/remove_property_action.dart';
import 'package:junction_frame/store/app_state.dart';

class InventoryDetailsConnector {
  final Inventory inventory;
  final Function(int) removeProperty;
  final Function(List<Properties>) updateProperties;
  final Function(Function()) upsert;
  final Function(String) updateComment;

  InventoryDetailsConnector(this.inventory, this.removeProperty,
      this.updateProperties, this.upsert, this.updateComment);

  static InventoryDetailsConnector fromStore(Store<AppState> store) {
    return InventoryDetailsConnector(store.state.selectedInventory!, (index) {
      store.dispatch(RemovePropertyAction(index: index));
    }, (properties) {
      store.dispatch(UpdateProperties(properties: properties));
    },
        (callback) => store
            .dispatchAndWait(AbsoulteDominatorUpsertAction())
            .then((_) => callback()),
        (text) => store.dispatch(CommentSupplierAction(commentValue: text)));
  }
}
