import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/screens/multiple_object_identify/multiple_object_identify_connector.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/image_verifier/image_verifier.dart';
import 'package:junction_frame/widgets/text_widgets.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class MultipleObjectIdentify extends StatelessWidget {
  const MultipleObjectIdentify({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, MultipleObjectIdentifyConnector>(
      converter: (store) => MultipleObjectIdentifyConnector.fromStore(store),
      builder: (BuildContext context, MultipleObjectIdentifyConnector vm) =>
          ImageVerifier(
              allowRevalidation: true,
              namedPath: 'multiple-images-verification',
              onSubmit: (file) {
                OverlayLoadingProgress.start(context);
                return vm.onSubmit(file, () {
                  OverlayLoadingProgress.stop();
                  context.goNamed('multiple-images-verification');
                });
              },
              bottomContainerTexts: const [
            HeaderText('If you want to upload this photo choose “Next”'),
            SizedBox(
              height: 10,
            ),
            SubHeaderText('To add more photos click “+”.'),
            SizedBox(
              height: 10,
            ),
            SubHeaderText('If not click “Back” and take a new picture.'),
            SizedBox(
              height: 10,
            )
          ]),
    );
  }
}
