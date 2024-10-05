import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/home.dart';

void main() {
  runApp(
    ProviderScope(
      child: DevicePreview(
        builder: (_) => const Home(),
      ),
    ),
  );
}
