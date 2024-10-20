import 'dart:io';

import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/home.dart';
import 'package:parmosys_flutter/providers/app_documents_directory_provider.dart';
import 'package:parmosys_flutter/providers/shared_preferences_provider.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();
  final prefs = await SharedPreferences.getInstance();

  await Firebase.initializeApp();

  runApp(
    ProviderScope(
      overrides: [
        appDocumentsDirectoryProvider.overrideWithValue(directory),
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: DevicePreview(
        tools: [
          ...DevicePreview.defaultTools,
          DevicePreviewScreenshot(onScreenshot: screenshotAsFiles(Directory(downloadDirectory))),
        ],
        builder: (_) => const Home(),
      ),
    ),
  );
}
