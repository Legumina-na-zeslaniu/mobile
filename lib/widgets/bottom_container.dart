import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  final List<Widget> children;
  const BottomContainer({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: kElevationToShadow[4],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, children: children),
        ));
  }
}
