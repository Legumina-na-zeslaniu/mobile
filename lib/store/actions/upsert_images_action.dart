import 'dart:async';

import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:graphql_flutter/graphql_flutter.dart' as graphql;
import 'package:http/http.dart' as http;
import 'package:junction_frame/api/grqphql_client.dart';
import 'package:junction_frame/api/queries/images.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/actions/show_loading_action.dart';
import 'package:junction_frame/store/actions/upload_images_action.dart';
import 'package:junction_frame/store/app_state.dart';

class UpsertImagesAction extends ReduxAction<AppState> {
  final String comments;

  UpsertImagesAction({required this.comments});

  @override
  Future<AppState> reduce() async {
    store.dispatch(ShowLoadingAction(dataLoadState: DataLoadState.loadRequest));

    Inventory selectedInventory = store.state.selectedInventory!;

    final graphql.MutationOptions options = graphql.MutationOptions(
      document: graphql.gql(upsertInventoryQuery),
      variables: {
        "comments": comments,
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
      // Inventory inventory = Inventory.fromJson(result.data!['classifyObject']);
      print(result.data);

      return state.copyWith(dataLoadState: DataLoadState.loaded);
    }

    return state;
  }
}
