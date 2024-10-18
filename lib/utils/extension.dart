import 'package:flutter/material.dart';
import 'package:parmosys_flutter/models/parking_space.dart';

extension BuildContextExt on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
}

extension StringExt on String {
  String toSnakeCase() {
    final wordList = split(' ');
    return wordList.isEmpty ? toLowerCase() : wordList.join('_').toLowerCase();
  }
}

extension ParkingSpaceExt on ParkingSpace {
  bool isMatch(ParkingSpace updatedParkingSpace) =>
      number == updatedParkingSpace.number && collectionId == updatedParkingSpace.collectionId;
}
