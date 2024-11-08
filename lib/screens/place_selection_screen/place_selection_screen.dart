import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';

class PlaceSelectionScreen extends StatelessWidget {
  const PlaceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return InAppWebView(
      onProgressChanged:
          (InAppWebViewController inAppWebViewController, int progress) {
        // controller.setProgress(progress);
      },
      onWebViewCreated: (InAppWebViewController inAppWebViewController) {
        // controller.setWebViewController(inAppWebViewController);
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
    );
  }
}
