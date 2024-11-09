import 'package:flutter/material.dart';
import 'package:junction_frame/themes/colors.dart';

class InversedButton extends StatelessWidget {
  final Function() onPress;
  final double? width;
  final double? height;
  final String title;
  final bool enabled;

  const InversedButton(
      {super.key,
      this.enabled = true,
      required this.title,
      required this.onPress,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: RawMaterialButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          fillColor: CustomColors.orange,
          onPressed: !enabled ? null : () => onPress(),
          child: Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }
}

class LightButton extends StatelessWidget {
  final Function() onPress;
  final double? width;
  final double? height;
  final String title;
  final double? borderRadius;

  const LightButton(
      {super.key,
      required this.title,
      required this.onPress,
      this.width,
      this.borderRadius,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 20),
          border: Border.all(color: CustomColors.orange, width: 2)),
      child: RawMaterialButton(
        fillColor: Colors.white,
        onPressed: () => onPress(),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 20)),
        child: Text(title,
            style: const TextStyle(
                color: CustomColors.orange, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
