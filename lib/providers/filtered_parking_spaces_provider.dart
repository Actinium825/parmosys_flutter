import 'package:dartx/dartx.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/models/parking_space.dart';
import 'package:parmosys_flutter/providers/parking_spaces_provider.dart';

final filteredParkingSpacesProvider = Provider.autoDispose.family<List<ParkingSpace>, String>((ref, collectionId) {
  final parkingSpacesValue = ref.watch(parkingSpacesProvider);

  return parkingSpacesValue.maybeWhen(
    data: (parkingSpaces) => parkingSpaces
        .where((parkingSpace) => parkingSpace.collectionId == collectionId)
        .sortedBy((parkingSpace) => parkingSpace.number),
    orElse: List.empty,
  );
});
