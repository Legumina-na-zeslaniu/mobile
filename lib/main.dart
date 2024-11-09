import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:junction_frame/navigation/routing.dart';
import 'package:junction_frame/store/app_state.dart';

void main() {
  runApp(StoreProvider(store: store, child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
