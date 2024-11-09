import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/widgets/summary_widget/summary_widget.dart';

class AcceptInventoryType extends StatelessWidget {
  const AcceptInventoryType({super.key});

  @override
  Widget build(BuildContext context) {
    return SummaryWidget(goFurtherAction: () async {
      await availableCameras().then((value) => context.goNamed(
            'multiple-images',
            extra: value,
          ));
    });
  }
}
