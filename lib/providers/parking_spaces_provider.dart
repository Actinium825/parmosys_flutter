import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:parmosys_flutter/models/dto/parking_space_dto.dart';
import 'package:parmosys_flutter/models/parking_space.dart';
import 'package:parmosys_flutter/providers/appwrite_client_provider.dart';
import 'package:parmosys_flutter/providers/isar_provider.dart';
import 'package:parmosys_flutter/providers/loading_state_provider.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parking_spaces_provider.g.dart';

@riverpod
class ParkingSpaces extends _$ParkingSpaces {
  @override
  Stream<List<ParkingSpaceDto>> build([String? area]) {
    final isar = ref.read(isarInstanceProvider);
    return area != null
        ? isar.parkingSpaceDtos.filter().areaEqualTo(area).sortByNumber().watch(fireImmediately: true)
        : isar.parkingSpaceDtos.where().watch(fireImmediately: true);
  }

  void getAllDocuments() async {
    final loadingState = ref.read(loadingStateProvider.notifier);

    loadingState.setLoading();

    final client = ref.read(appwriteClientProvider);
    final database = Databases(client);
    final isar = ref.read(isarInstanceProvider);
    final areas = collegesAreas
      ..followedBy(hallsAreas)
      ..followedBy(recreationalAreas);

    try {
      await Future.forEach(
        areas,
        (area) => _getDocuments(database, isar, area.toSnakeCase()),
      );
    } catch (e) {
      debugPrint(e.toString());
    }

    loadingState.removeLoading();
  }

  Future<void> _getDocuments(Databases database, Isar isar, String collectionId) async {
    final results = await database.listDocuments(
      databaseId: appwriteDatabaseId,
      collectionId: collectionId,
    );
    final parkingSpaceDtos = isar.parkingSpaceDtos;
    final documents = results.documents;

    for (final document in documents) {
      final parkingSpace = ParkingSpace.fromJson(document.data).toDto();
      final existingLocalID = parkingSpaceDtos
          .filter()
          .areaEqualTo(parkingSpace.area)
          .and()
          .numberEqualTo(parkingSpace.number)
          .localIDProperty()
          .findFirstSync();

      isar.writeTxnSync(() => parkingSpaceDtos.putSync(parkingSpace..localID = existingLocalID));
    }
  }

  void updateParkingSpace(Map<String, dynamic> data, String event) {
    final updatedParkingSpace = ParkingSpace.fromJson(data).toDto();
    final isar = ref.read(isarInstanceProvider);
    final parkingSpaceDtos = isar.parkingSpaceDtos;

    switch (event) {
      case update || create:
        final existingParkingSpace = parkingSpaceDtos
            .filter()
            .areaEqualTo(updatedParkingSpace.area)
            .and()
            .numberEqualTo(updatedParkingSpace.number)
            .build()
            .findFirstSync();

        isar.writeTxnSync(() => parkingSpaceDtos.putSync(updatedParkingSpace..localID = existingParkingSpace?.localID));
      case delete:
        final deletedLocalID = parkingSpaceDtos
            .filter()
            .areaEqualTo(updatedParkingSpace.area)
            .and()
            .numberEqualTo(updatedParkingSpace.number)
            .localIDProperty()
            .build()
            .findFirstSync();

        if (deletedLocalID != null) isar.writeTxnSync(() => parkingSpaceDtos.deleteSync(deletedLocalID));
    }
  }
}
