// ignore_for_file: use_build_context_synchronously

import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/store/actions/fetch_inventory_details.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/3d_viewer/viewer_3d.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
import 'package:junction_frame/widgets/buttons.dart';
import 'package:junction_frame/widgets/text_widgets.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class SelectFromModalPage extends StatelessWidget {
  const SelectFromModalPage({super.key});

  Widget renderBottomContainer(
      Function() navigationCallback, Function() chooseBuildingCallback) {
    return BottomContainer(children: [
      const HeaderText('Select a building, and then optionally'),
      const SizedBox(
        height: 10,
      ),
      const HeaderText('item in it'),
      const SizedBox(
        height: 15,
      ),
      LightButton(
          height: 50,
          width: double.infinity,
          title: 'List of assets',
          onPress: () => chooseBuildingCallback()),
      const SizedBox(
        height: 15,
      ),
      InversedButton(
          height: 50,
          width: double.infinity,
          title: 'Add new asset',
          onPress: () => navigationCallback()),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Connector>(
      converter: (store) => _Connector.fromStore(store),
      builder: (context, vm) => Scaffold(
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              const Viewer3D(),
              renderBottomContainer(
                  () async => await availableCameras().then(
                      (value) => context.goNamed('take-photo', extra: value)),
                  () {
                OverlayLoadingProgress.start(context);
                return vm.fetchBuildingsInformation(() {
                  OverlayLoadingProgress.stop();
                  context.pushNamed('all-inventory');
                });
              })
            ],
          ),
        ),
      ),
    );
  }
}

class _Connector {
  final Function(Function()) fetchBuildingsInformation;

  _Connector({required this.fetchBuildingsInformation});

  static _Connector fromStore(Store<AppState> store) {
    return _Connector(
        fetchBuildingsInformation: (callback) => store
            .dispatchAndWait(FetchInventoryDetails())
            .then((_) => callback()));
  }
}
