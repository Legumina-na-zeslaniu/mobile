import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/api/schemas/inventory.dart';
import 'package:junction_frame/store/actions/upsert_images_action.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/3d_viewer/viewer_3d.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
import 'package:junction_frame/widgets/buttons.dart';
import 'package:junction_frame/widgets/text_widgets.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class PlaceSelectionScreen extends StatefulWidget {
  const PlaceSelectionScreen({super.key});

  @override
  State<PlaceSelectionScreen> createState() => _PlaceSelectionScreenState();
}

class _PlaceSelectionScreenState extends State<PlaceSelectionScreen> {
  bool isPlaceChosen = false;
  bool isDataSubmitted = false;

  Widget renderBottomContainer(BuildContext context, Function onDataSubmitted) {
    if (isDataSubmitted) {
      return BottomContainer(
        children: [
          const HeaderText(
              "Adding the item to the building plan may take a few minutes. You will be notified once the process is complete."),
          const SizedBox(
            height: 15,
          ),
          Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: InversedButton(
                  title: 'Home',
                  height: 50,
                  width: double.infinity,
                  onPress: () => context.goNamed('SelectFromModalPage')))
        ],
      );
    }

    return BottomContainer(
      children: [
        const HeaderText(
            "Mark the item's location in the building by clicking the correct spot with place marker on the building plan."),
        const SizedBox(
          height: 15,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: InversedButton(
                title: 'Confirm location',
                height: 50,
                width: double.infinity,
                onPress: () => onDataSubmitted()))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Connector>(
      converter: (store) => _Connector.fromStore(store),
      builder: (BuildContext context, _Connector vm) => Scaffold(
        body: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                Viewer3D(
                  optionalParams: "?modelId=MOCKED&buildingId=${vm.buildingId}",
                ),
                renderBottomContainer(context, () {
                  OverlayLoadingProgress.start(context);
                  return vm.submitData(() {
                    OverlayLoadingProgress.stop();
                    setState(() => isDataSubmitted = true);
                  });
                }),
              ],
            )),
      ),
    );
  }
}

class _Connector {
  final String buildingId;
  final Function(Function()) submitData;

  _Connector({required this.buildingId, required this.submitData});

  static _Connector fromStore(Store<AppState> store) {
    return _Connector(
        buildingId: store.state.selectedBuildingId ?? '',
        submitData: (Function() onDataSubmittedCallback) {
          store.dispatchAndWait(UpsertImagesAction()).then((_) {
            onDataSubmittedCallback();
          });
        });
  }
}
