# PermissionFlow

[![pub package](https://img.shields.io/pub/v/permission_flow.svg)](https://pub.dev/packages/permission_flow)

A simple and unified permission management package for Flutter apps.  
Handles common permissions like **Camera, Microphone, Storage, Location, and Notifications**, with **rationale dialogs** and clean APIs. Built on top of `permission_handler` for v1 and designed to evolve with native implementations in the future.

---

## Features

- Unified API for all common permissions
- Customizable rationale dialogs
- Handles `granted`, `denied`, and `permanentlyDenied` cases
- Easy to integrate and extend
- Future-proof: replaceable engine for native implementations

---

## Installation

Add the dependency in your `pubspec.yaml`:

```yaml
dependencies:
  permission_flow:
    path: ../ # or use the published version when available


Usage
Import:
import 'package:permission_flow/permission_flow.dart';

Request a single permission:
final result = await PermissionFlow.camera(
  rationale: const PermissionRationale(
    title: "Camera Permission",
    message: "Camera access is required to scan QR codes.",
    confirmText: "Allow",
    cancelText: "Deny",
  ),
).request(context);

Handle the result:
switch (result) {
  case PermissionResult.granted:
    print("Camera Permission Granted");
    break;
  case PermissionResult.denied:
    print("Camera Permission Denied");
    break;
  case PermissionResult.permanentlyDenied:
    print("Camera Permission Permanently Denied. Open app settings to enable.");
    break;
}

Request other permissions:
PermissionFlow.microphone(rationale: ...).request(context);
PermissionFlow.storage(rationale: ...).request(context);
PermissionFlow.location(rationale: ...).request(context);
PermissionFlow.notification(rationale: ...).request(context);

Example

Check the example/ folder for a working Flutter app demonstrating all permission requests with rationale dialogs.

Contributing

Contributions are welcome! Feel free to submit pull requests or issues.
