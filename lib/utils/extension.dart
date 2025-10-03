import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:parmosys_flutter/models/dto/parking_space_dto.dart';
import 'package:parmosys_flutter/models/parking_space.dart';
import 'package:parmosys_flutter/utils/strings.dart';

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
  ParkingSpaceDto toDto() {
    final match = RegExp(digits).stringMatch(id ?? '') ?? '';
    final number = int.tryParse(match) ?? 0;

    return ParkingSpaceDto(
      area: collectionId ?? '',
      isAvailable: isAvailable ?? false,
      number: number,
    );
  }
}

extension ParkingSpaceDtoExt on ParkingSpaceDto {
  bool isMatch(ParkingSpaceDto updatedParkingSpace) =>
      number == updatedParkingSpace.number && area == updatedParkingSpace.area;
}

extension DocumentChangeTypeExt on DocumentChangeType {
  String toEventString() => switch (this) {
        DocumentChangeType.added => create,
        DocumentChangeType.modified => update,
        DocumentChangeType.removed => delete,
      };
}

extension ListExt<T> on List<T> {
  List<E> forLoop<E>(E Function(T element) callback) {
    final result = <E>[];

    for (int index = 0; index < length; index++) {
      final mappedValue = callback(this[index]);
      result.add(mappedValue);
    }

    return result;
  }

  bool everyForLoop(bool Function(T element) test) {
    for (int index = 0; index < length; index++) {
      if (!test(this[index])) return false;
    }
    return true;
  }
}
