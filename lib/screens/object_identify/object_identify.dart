import 'package:async_redux/async_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/screens/object_identify/object_identify_connector.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/image_verifier/image_verifier.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class ObjectIdentify extends StatelessWidget {
  const ObjectIdentify({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, ObjectIdentifyConnector>(
        converter: (store) => ObjectIdentifyConnector.fromStore(store),
        builder: (BuildContext context, ObjectIdentifyConnector conn) =>
            ImageVerifier(
                namedPath: 'accept-inventory',
                onSubmit: (file) {
                  OverlayLoadingProgress.start(context);

                  return conn.onSubmit(file, () {
                    context.goNamed('accept-inventory');
                    OverlayLoadingProgress.stop();
                  });
                }));
  }
}
