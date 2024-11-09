// ignore_for_file: use_build_context_synchronously

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/widgets/3d_viewer/viewer_3d.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
import 'package:junction_frame/widgets/buttons.dart';
import 'package:junction_frame/widgets/text_widgets.dart';

class SelectFromModalPage extends StatelessWidget {
  const SelectFromModalPage({super.key});

  Widget renderBottomContainer(Function() navigationCallback) {
    return BottomContainer(children: [
      const HeaderText('Select a building, and then optionally'),
      const SizedBox(
        height: 10,
      ),
      const HeaderText('item in it'),
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
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            const Viewer3D(),
            renderBottomContainer(
              () async => await availableCameras()
                  .then((value) => context.goNamed('take-photo', extra: value)),
            )
          ],
        ),
      ),
    );
  }
}
