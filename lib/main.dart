import 'dart:io';

import 'package:device_preview_screenshot/device_preview_screenshot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:parmosys_flutter/feature/home.dart';
import 'package:parmosys_flutter/models/dto/parking_space_dto.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:path_provider/path_provider.dart';

late final Isar isar;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final directory = await getApplicationDocumentsDirectory();

  isar = Isar.getInstance() ?? Isar.openSync([ParkingSpaceDtoSchema], directory: directory.path);

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
