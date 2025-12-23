import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'permission_type.dart';
import 'permission_result.dart';
import 'rationale.dart';

class PermissionFlow {
  final Permission permission;
  final PermissionRationale? rationale;

  PermissionFlow._(this.permission, this.rationale);

  /// Factories
  factory PermissionFlow.camera({PermissionRationale? rationale}) =>
      PermissionFlow._(Permission.camera, rationale);

  factory PermissionFlow.location({PermissionRationale? rationale}) =>
      PermissionFlow._(Permission.location, rationale);

  factory PermissionFlow.notification({PermissionRationale? rationale}) =>
      PermissionFlow._(Permission.notification, rationale);

  factory PermissionFlow.microphone({PermissionRationale? rationale}) =>
      PermissionFlow._(Permission.microphone, rationale);

  factory PermissionFlow.storage({PermissionRationale? rationale}) =>
      PermissionFlow._(Permission.storage, rationale);

  Future<PermissionResult> request({BuildContext? context}) async {
    if (rationale != null && context != null) {
      final proceed = await _showRationale(context);
      if (!proceed) return PermissionResult.denied;
    }

    final status = await permission.request();

    if (status.isGranted) return PermissionResult.granted;
    if (status.isPermanentlyDenied) {
      openAppSettings();
      return PermissionResult.permanentlyDenied;
    }
    return PermissionResult.denied;
  }

  Future<bool> _showRationale(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(rationale!.title),
            content: Text(rationale!.message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text(rationale!.cancelText ?? 'Cancel'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(rationale!.confirmText ?? 'Continue'),
              ),
            ],
          ),
        ) ??
        false;
  }
}
