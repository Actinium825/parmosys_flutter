import 'package:flutter/material.dart';

extension BuildContextExt on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension StringExt on String {
  String toSnakeCase() {
    final wordList = split(' ');
    return wordList.isEmpty ? toLowerCase() : wordList.join('_').toLowerCase();
  }
}
