import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/home.dart';

void main() {
  runApp(const ProviderScope(child: Home()));
}
