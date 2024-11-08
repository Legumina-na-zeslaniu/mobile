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


// hild: InAppWebView(
//             onProgressChanged:
//                 (InAppWebViewController inAppWebViewController, int progress) {
//               // controller.setProgress(progress);
//             },
//             onWebViewCreated: (InAppWebViewController inAppWebViewController) {
//               // controller.setWebViewController(inAppWebViewController);
//             },
//             onPermissionRequest: (InAppWebViewController controller,
//                 PermissionRequest permissionRequest) async {
//               if (permissionRequest.resources
//                   .contains(PermissionResourceType.MICROPHONE)) {
//                 final PermissionStatus permissionStatus =
//                     await Permission.microphone.request();
//                 if (permissionStatus.isGranted) {
//                   return PermissionResponse(
//                     resources: permissionRequest.resources,
//                     action: PermissionResponseAction.GRANT,
//                   );
//                 } else if (permissionStatus.isDenied) {
//                   return PermissionResponse(
//                     resources: permissionRequest.resources,
//                     action: PermissionResponseAction.DENY,
//                   );
//                 }
//               }
//               return null;
//             },
//             initialUrlRequest:
//                 URLRequest(url: WebUri.uri(Uri.parse("https://flutter.dev/"))),
//           ),