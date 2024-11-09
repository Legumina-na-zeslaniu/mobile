import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:http/http.dart' as http;
import 'package:async_redux/async_redux.dart';
import 'package:junction_frame/api/grqphql_client.dart';
import 'package:junction_frame/api/queries/images.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/actions/show_loading_action.dart';
import 'package:junction_frame/store/app_state.dart';

class FetchInventoryDetails extends ReduxAction<AppState> {
  @override
  Future<AppState> reduce() async {
    store.dispatch(ShowLoadingAction(dataLoadState: DataLoadState.loadRequest));

    final graphql.QueryOptions options =
        graphql.QueryOptions(document: graphql.gql(getInventoryQuery));

    final graphql.QueryResult result = await client
        .query(options)
        .timeout(const Duration(seconds: 20), onTimeout: () {
      throw Exception;
    });

    if (result.data != null) {
      List<Inventory> inventoryList = (result.data!['getAllInventory'] as List)
          .map((e) {
            return Inventory.fromJson(e);
          })
          .map((e) => e as Inventory)
          .toList();

      print("FETCH ALL INVENTORY");
      print(inventoryList);

      return state.copyWith(
          dataLoadState: DataLoadState.loaded, inventoryList: inventoryList);
    }

    return state;
  }
}
