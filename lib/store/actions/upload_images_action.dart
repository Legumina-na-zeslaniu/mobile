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

class UploadImagesAction extends ReduxAction<AppState> {
  final XFile file;

  UploadImagesAction({required this.file});

  @override
  Future<AppState> reduce() async {
    store.dispatch(ShowLoadingAction(dataLoadState: DataLoadState.loadRequest));

    var byteData = file.readAsBytes();
    http.MultipartFile mpf =
        http.MultipartFile.fromBytes('file', await byteData);

    final graphql.MutationOptions options = graphql.MutationOptions(
      document: graphql.gql(uploadImageQuery),
      variables: {"file": mpf},
    );

    final graphql.QueryResult result = await client
        .mutate(options)
        .timeout(const Duration(seconds: 20), onTimeout: () {
      throw Exception;
    });

    if (result.data != null) {
      Inventory inventory = Inventory.fromJson(result.data!['classifyObject']);

      return state.copyWith(
          dataLoadState: DataLoadState.loaded, selectedInventory: inventory);
    }

    return state;
  }
}
