import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/widgets/3d_viewer/viewer_3d.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
import 'package:junction_frame/widgets/buttons.dart';
import 'package:junction_frame/widgets/text_widgets.dart';

class PlaceSelectionScreen extends StatefulWidget {
  const PlaceSelectionScreen({super.key});

  @override
  State<PlaceSelectionScreen> createState() => _PlaceSelectionScreenState();
}

class _PlaceSelectionScreenState extends State<PlaceSelectionScreen> {
  bool isPlaceChosen = false;
  bool isDataSubmitted = false;

  Widget renderBottomContainer(BuildContext context) {
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
                onPress: () => setState(() {
                      isDataSubmitted = true;
                    })))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              const Viewer3D(),
              renderBottomContainer(context),
            ],
          )),
    );
  }
}
