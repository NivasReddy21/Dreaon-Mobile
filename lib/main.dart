import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      builder: (context) => MyApp(),
      enabled: false,
    ),
  );
}
