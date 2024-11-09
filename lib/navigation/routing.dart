import 'package:camera/camera.dart';
import 'package:go_router/go_router.dart';
import 'package:junction_frame/screens/accept_inventory_type/accept_inventory_type.dart';
import 'package:junction_frame/screens/all-inventory-page/all_inventory_page.dart';
import 'package:junction_frame/screens/home_screen.dart';
import 'package:junction_frame/screens/multiple_images_verification/multiple_images_verification.dart';
import 'package:junction_frame/screens/multiple_object_identify/multiple_object_identify.dart';
import 'package:junction_frame/screens/object_identify/object_identify.dart';
import 'package:junction_frame/screens/place_selection_screen/place_selection_screen.dart';
import 'package:junction_frame/screens/select_from_model/select_from_modal_page.dart';
import 'package:junction_frame/screens/take_photo_screen/additional_take_photo_screen.dart';
import 'package:junction_frame/screens/take_photo_screen/inventory_take_photo_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        name: 'SelectFromModalPage',
        path: '/',
        builder: (context, state) => const SelectFromModalPage()),
    GoRoute(
        path: '/all-inventory',
        name: 'all-inventory',
        builder: (context, state) => const AllInventoryPage()),
    GoRoute(
      name: 'home',
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
        name: 'take-photo',
        path: '/take-photo',
        builder: (context, state) {
          List<CameraDescription> cameras =
              state.extra as List<CameraDescription>;
          return InventoryTakePhotoScreen(
            cameras: cameras,
          );
        }),
    GoRoute(
      name: 'object-identify',
      path: '/object-identify',
      builder: (context, state) => const ObjectIdentify(),
    ),
    GoRoute(
      name: 'multiple-object-identify',
      path: '/multiple-object-identify',
      builder: (context, state) => const MultipleObjectIdentify(),
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
    GoRoute(
        name: 'multiple-images',
        path: '/multiple-images',
        builder: (context, state) {
          List<CameraDescription> cameras =
              state.extra as List<CameraDescription>;
          return AdditionalTakePhotoScreen(
            cameras: cameras,
          );
        }),
    GoRoute(
        name: 'multiple-images-verification',
        path: '/multiple-images-verification',
        builder: (context, state) {
          return MultipleImagesVerification();
        }),
  ],
);
