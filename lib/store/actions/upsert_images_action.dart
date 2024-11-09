import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:http/http.dart' as http;
import 'package:junction_frame/api/grqphql_client.dart';
import 'package:junction_frame/api/queries/images.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/actions/show_loading_action.dart';
import 'package:junction_frame/store/app_state.dart';

class UpsertImagesAction extends ReduxAction<AppState> {
  final XFile additionalInformationData;

  UpsertImagesAction({required this.additionalInformationData});

  @override
  Future<AppState> reduce() async {
    store.dispatch(ShowLoadingAction(dataLoadState: DataLoadState.loadRequest));

    print("NIGRO");

    Inventory selectedInventory = store.state.selectedInventory!;
    var b0 = store.state.mainInventoryImage!.readAsBytes();
    var b1 = additionalInformationData.readAsBytes();
    http.MultipartFile mpf0 = http.MultipartFile.fromBytes('file', await b0);
    http.MultipartFile mpf1 = http.MultipartFile.fromBytes('file', await b1);

    final graphql.MutationOptions options = graphql.MutationOptions(
      document: graphql.gql(upsertInventoryQuery),
      variables: {
        "input": {
          "buildingId": selectedInventory.buildingId ?? '-',
          "comments": selectedInventory.comments ?? "",
          "id": selectedInventory.id ?? "_id",
          "files": [mpf0, mpf1],
          "localization": selectedInventory.localization == null
              ? null
              : {
                  'x': selectedInventory.localization!.x,
                  'y': selectedInventory.localization!.y,
                  'z': selectedInventory.localization!.z
                },
          "properties": store.state.selectedInventory!.properties?.map((e) {
            return {
              "field": e.field,
              "value": e.value,
            };
          }).toList(),
        }
      },
    );

    final graphql.QueryResult result = await client
        .mutate(options)
        .timeout(const Duration(seconds: 20), onTimeout: () {
      throw Exception;
    });

    print(result);

    if (result.data != null) {
      // Inventory inventory = Inventory.fromJson(result.data!['classifyObject']);
      print(result.data);

      return state.copyWith(dataLoadState: DataLoadState.loaded);
    }

    return state;
  }
}
