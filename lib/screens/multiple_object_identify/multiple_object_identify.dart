import 'package:flutter/material.dart';
import 'package:junction_frame/widgets/image_verifier/image_verifier.dart';
import 'package:junction_frame/widgets/text_widgets.dart';

class MultipleObjectIdentify extends StatelessWidget {
  const MultipleObjectIdentify({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageVerifier(
        allowRevalidation: true,
        namedPath: 'multiple-images-verification',
        onSubmit: (file) => {},
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
        ]);
  }
}
