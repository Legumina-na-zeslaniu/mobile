import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:http/http.dart' as http;
import 'package:junction_frame/api/grqphql_client.dart';
import 'package:junction_frame/api/queries/images.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/actions/show_loading_action.dart';
import 'package:junction_frame/store/app_state.dart';

class UpsertImagesAction extends ReduxAction<AppState> {
  UpsertImagesAction();

  @override
  Future<AppState> reduce() async {
    store.dispatch(ShowLoadingAction(dataLoadState: DataLoadState.loadRequest));

    var byteData1 = store.state.mainInventoryImage!.readAsBytes();

    var byteData2 = store.state.additionalInformationImage!.readAsBytes();

    http.MultipartFile mpf1 =
        http.MultipartFile.fromBytes('file', await byteData1);

    http.MultipartFile mpf2 =
        http.MultipartFile.fromBytes('file', await byteData2);

    Inventory selectedInventory = store.state.selectedInventory!;

    final graphql.MutationOptions options = graphql.MutationOptions(
      document: graphql.gql(upsertInventoryQuery),
      variables: {
        "comments": store.state.selectedInventory!.comments ?? '',
        "buildingId": store.state.selectedBuildingId!,
        "localization": {
          "x": store.state.selectedInventory!.localization!.x,
          "y": store.state.selectedInventory!.localization!.y,
          "z": store.state.selectedInventory!.localization!.z,
        },
        "files": [mpf1, mpf2],
        "properties": selectedInventory.properties!.map((e) {
          return {
            "field": e.field,
            "value": e.value,
          };
        }).toList(),
      },
    );

    final graphql.QueryResult result = await client
        .mutate(options)
        .timeout(const Duration(seconds: 20), onTimeout: () {
      throw Exception;
    });

    print(result);

    if (result.data != null) {
      Inventory inventory = Inventory.fromJson(result.data!['upsertInventory']);
      print(inventory);

      return state.copyWith(
          dataLoadState: DataLoadState.loaded, selectedInventory: inventory);
    }

    return state;
  }
}
