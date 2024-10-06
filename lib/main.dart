import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/home.dart';
import 'package:parmosys_flutter/utils/strings.dart';

void main() {
  runApp(
    ProviderScope(
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
