import 'package:flutter/material.dart';
import 'package:permission_flow/permission_flow.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PermissionFlow Example',
      theme: ThemeData(primarySwatch: Colors.blueGrey),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Helper function to request permission and show SnackBar
  Future<void> _requestPermission(
    BuildContext context,
    PermissionFlow permissionFlow,
  ) async {
    final result = await permissionFlow.request(context: context);

    String message;
    switch (result) {
      case PermissionResult.granted:
        message = "${permissionFlow.permission} Permission Granted";
        break;
      case PermissionResult.denied:
        message = "${permissionFlow.permission} Permission Denied";
        break;
      case PermissionResult.permanentlyDenied:
        message =
            "${permissionFlow.permission} Permanently Denied. Open app settings to enable.";
        break;
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PermissionFlow Demo")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => _requestPermission(
                  context,
                  PermissionFlow.camera(
                    rationale: const PermissionRationale(
                      title: "Camera Permission",
                      message:
                          "Camera access is required to take photos or scan QR codes.",
                    ),
                  ),
                ),
                child: const Text("Request Camera Permission"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _requestPermission(
                  context,
                  PermissionFlow.microphone(
                    rationale: const PermissionRationale(
                      title: "Microphone Permission",
                      message:
                          "Microphone access is required for recording audio.",
                    ),
                  ),
                ),
                child: const Text("Request Microphone Permission"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _requestPermission(
                  context,
                  PermissionFlow.storage(
                    rationale: const PermissionRationale(
                      title: "Storage Permission",
                      message:
                          "Storage access is required to save or read files.",
                    ),
                  ),
                ),
                child: const Text("Request Storage Permission"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _requestPermission(
                  context,
                  PermissionFlow.location(
                    rationale: const PermissionRationale(
                      title: "Location Permission",
                      message:
                          "Location access is required to get your current location.",
                    ),
                  ),
                ),
                child: const Text("Request Location Permission"),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _requestPermission(
                  context,
                  PermissionFlow.notification(
                    rationale: const PermissionRationale(
                      title: "Notification Permission",
                      message:
                          "Notification access is required to send you alerts.",
                    ),
                  ),
                ),
                child: const Text("Request Notification Permission"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
