import 'package:permission_handler/permission_handler.dart' as handler;

import 'package:flutter/services.dart';

class Permissions {
  static Future<bool> cameraAndMicrophonePermissionsGranted() async {
    handler.PermissionStatus cameraPermissionStatus =
        await _getCameraPermission();
    handler.PermissionStatus microphonePermissionStatus =
        await _getMicrophonePermission();

    if (cameraPermissionStatus == handler.PermissionStatus.granted &&
        microphonePermissionStatus == handler.PermissionStatus.granted) {
      return true;
    } else {
      _handleInvalidPermissions(
          cameraPermissionStatus, microphonePermissionStatus);
      return false;
    }
  }

  static Future<handler.PermissionStatus> _getCameraPermission() async {
    var status = await handler.Permission.photos.request();
    if (status != handler.PermissionStatus.granted &&
        status != handler.PermissionStatus.denied) {
      return handler.PermissionStatus.restricted;
    } else {
      return status;
    }
  }

  static Future<handler.PermissionStatus> _getMicrophonePermission() async {
    var status = await handler.Permission.microphone.request();
    if (status != handler.PermissionStatus.granted &&
        status != handler.PermissionStatus.denied) {
         return  handler.PermissionStatus.restricted;
    } else {
      return status;
    }
  }

  static void _handleInvalidPermissions(
    handler.PermissionStatus cameraPermissionStatus,
    handler.PermissionStatus microphonePermissionStatus,
  ) {
    if (cameraPermissionStatus == handler.PermissionStatus.denied &&
        microphonePermissionStatus == handler.PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DENIED",
          message: "Access to camera and microphone denied",
          details: null);
    } else if (cameraPermissionStatus == handler.PermissionStatus.denied &&
        microphonePermissionStatus == handler.PermissionStatus.denied) {
      throw new PlatformException(
          code: "PERMISSION_DISABLED",
          message: "Location data is not available on device",
          details: null);
    }
  }
}
