import 'package:async_redux/async_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:junction_frame/store/app_state.dart';
import 'package:junction_frame/widgets/3d_viewer/viwer_3d_connector.dart';
import 'package:permission_handler/permission_handler.dart';

class Viewer3D extends StatelessWidget {
  const Viewer3D({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, Viwer3dConnector>(
      converter: (store) => Viwer3dConnector.fromStore(store),
      builder: (BuildContext context, Viwer3dConnector vm) => InAppWebView(
        onProgressChanged:
            (InAppWebViewController inAppWebViewController, int progress) {},
        onWebViewCreated: (InAppWebViewController inAppWebViewController) {
          inAppWebViewController.addJavaScriptHandler(
              handlerName: "savePosition",
              callback: (args) {
                return args.reduce((curr, next) => curr + next);
              });

          inAppWebViewController.addJavaScriptHandler(
              handlerName: "selectBuilding",
              callback: (args) {
                if (args.isNotEmpty) {
                  print("selected building: ${args[0]}");
                  vm.selectBuildingId(args[0]);
                }
              });
        },
        onPermissionRequest: (InAppWebViewController controller,
            PermissionRequest permissionRequest) async {
          if (permissionRequest.resources
              .contains(PermissionResourceType.MICROPHONE)) {
            final PermissionStatus permissionStatus =
                await Permission.microphone.request();
            if (permissionStatus.isGranted) {
              return PermissionResponse(
                resources: permissionRequest.resources,
                action: PermissionResponseAction.GRANT,
              );
            } else if (permissionStatus.isDenied) {
              return PermissionResponse(
                resources: permissionRequest.resources,
                action: PermissionResponseAction.DENY,
              );
            }
          }
          return null;
        },
        initialUrlRequest:
            URLRequest(url: WebUri.uri(Uri.parse("http://localhost:5173"))),
      ),
    );
  }
}
