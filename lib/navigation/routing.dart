import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/screens/accept_inventory_type/accept_inventory_type.dart';
import 'package:junction_frame/screens/home_screen.dart';
import 'package:junction_frame/screens/object_identify/object_identify.dart';
import 'package:junction_frame/screens/place_selection_screen/place_selection_screen.dart';
import 'package:junction_frame/screens/take_photo_screen/take_photo_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
        name: 'take-photo',
        path: '/take-photo',
        builder: (context, state) {
          List<CameraDescription> cameras =
              state.extra as List<CameraDescription>;
          return TakePhotoScreen(
            cameras: cameras,
          );
        }),
    GoRoute(
      name: 'object-identify',
      path: '/object-identify',
      builder: (context, state) => const ObjectIdentify(),
    ),
    GoRoute(
      name: 'accept-inventory',
      path: '/accept-inventory',
      builder: (context, state) => const AcceptInventoryType(),
    ),
    GoRoute(
      name: 'place-selection',
      path: '/place-selection',
      builder: (context, state) => const PlaceSelectionScreen(),
    ),
  ],
);
