import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:junction_frame/widgets/image_verifier/image_verifier.dart';

class ObjectIdentify extends StatelessWidget {
  const ObjectIdentify({super.key});

  @override
  Widget build(BuildContext context) {
    return const ImageVerifier(
      namedPath: 'accept-inventory',
    );
  }
}
