import 'package:flutter/material.dart';
import 'package:junction_frame/widgets/image_verifier/image_verifier.dart';

class MultipleObjectIdentify extends StatelessWidget {
  const MultipleObjectIdentify({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImageVerifier(
      allowRevalidation: true,
      namedPath: 'multiple-images-verification',
    );
  }
}
