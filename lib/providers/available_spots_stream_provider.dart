import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:parmosys_flutter/main.dart';
import 'package:parmosys_flutter/models/dto/parking_space_dto.dart';
import 'package:parmosys_flutter/providers/selected_category_provider.dart';
import 'package:parmosys_flutter/utils/extension.dart';

final availableSpotsStreamProvider = StreamProvider.autoDispose.family<List<ParkingSpaceDto>, String?>((ref, area) {
  if (area != null) {
    return isar.parkingSpaceDtos.filter().areaEqualTo(area).and().isAvailableEqualTo(true).watch(fireImmediately: true);
  }

  final selectedCategory = ref.read(selectedCategoryProvider);
  final areas = [...?selectedCategory?.areas];

  return isar.parkingSpaceDtos
      .filter()
      .anyOf<String, String>(areas, (query, area) => query.areaEqualTo(area.toSnakeCase()))
      .isAvailableEqualTo(true)
      .build()
      .watch(fireImmediately: true);
});
