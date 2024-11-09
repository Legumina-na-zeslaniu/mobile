import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/themes/colors.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
import 'package:junction_frame/widgets/buttons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget renderListOfItems() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: 2,
      itemBuilder: (context, index) {
        return ListTile(
          title: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: kElevationToShadow[4]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                      'To add an item to the building in your chosen location, take a photo of the item first.'),
                  SizedBox(
                    height: 50,
                    child: RawMaterialButton(
                        onPressed: () async {
                          await availableCameras().then((value) =>
                              context.goNamed('take-photo', extra: value));
                        },
                        fillColor: CustomColors.orange,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                          'Take a photo',
                          style: TextStyle(color: Colors.white),
                        )),
                  )
                ],
              )),
        );
      },
    );
  }

  Widget renderBottomDrawer(BuildContext context) {
    return BottomContainer(children: [
      const Text(
        'Location confirmed',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 20,
      ),
      const Text(
        'To add an item to the building in your chosen location, take a photo of the item first.',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
      const SizedBox(
        height: 20,
      ),
      SizedBox(
          height: 50,
          width: double.infinity,
          child: InversedButton(
            title: 'Take a photo',
            onPress: () async {
              await availableCameras()
                  .then((value) => context.goNamed('take-photo', extra: value));
            },
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // SizedBox(
            //   height: MediaQuery.of(context).size.height,
            // ),
            renderBottomDrawer(context),
          ],
        ),
      ),
    );
  }
}
