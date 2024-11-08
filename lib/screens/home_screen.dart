import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/navigation/routing.dart';

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
                        fillColor: Colors.orange,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: renderListOfItems(),
      ),
    );
  }
}
