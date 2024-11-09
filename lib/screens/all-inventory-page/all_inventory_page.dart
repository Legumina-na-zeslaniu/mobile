import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AllInventoryPage extends StatelessWidget {
  const AllInventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.chevron_left_rounded))
            ],
          )
        ],
      )),
    );
  }
}
