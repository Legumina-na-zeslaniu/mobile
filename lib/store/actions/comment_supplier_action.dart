import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/app_state.dart';

class CommentSupplierAction extends ReduxAction<AppState> {
  final String commentValue;

  CommentSupplierAction({required this.commentValue});

  @override
  AppState reduce() {
    var inv = store.state.selectedInventory!;
    return store.state.copyWith(
        selectedInventory: Inventory(
            localization: null,
            comments: inv.comments,
            properties: inv.properties));
  }
}