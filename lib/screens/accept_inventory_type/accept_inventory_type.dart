import 'dart:io';

import 'package:async_redux/async_redux.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/navigation/routing.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/bottom_container.dart';
import 'package:junction_frame/widgets/input_item.dart';
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
