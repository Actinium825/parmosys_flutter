import 'package:appwrite/appwrite.dart';
import 'package:dartx/dartx.dart';
import 'package:isar/isar.dart';
import 'package:parmosys_flutter/main.dart';
import 'package:parmosys_flutter/models/dto/parking_space_dto.dart';
import 'package:parmosys_flutter/models/parking_space.dart';
import 'package:parmosys_flutter/utils/env.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parking_spaces_provider.g.dart';

@riverpod
class ParkingSpaces extends _$ParkingSpaces {
  @override
  Stream<List<ParkingSpaceDto>> build([String? area]) => area != null
      ? isar.parkingSpaceDtos.filter().areaEqualTo(area).sortByNumber().watch(fireImmediately: true)
      : isar.parkingSpaceDtos.where().watch(fireImmediately: true);

  void getAllDocuments() {
    final areas = [...collegesAreas, ...hallsAreas, ...recreationalAreas];
    final client = Client()
      ..setEndpoint(Env.endpoint)
      ..setProject(Env.projectId);
    final database = Databases(client);
    final futures = <Future<void>>[];

    for (final area in areas) {
      futures.add(getDocuments(database, area.toSnakeCase()));
    }

    Future.wait(futures);
  }

  Future<void> getDocuments(Databases database, String collectionId) async {
    final results = await database.listDocuments(databaseId: Env.databaseId, collectionId: collectionId);
    final parkingSpaceDtos = isar.parkingSpaceDtos;

    for (final document in results.documents) {
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

  void updateParkingSpace(RealtimeMessage value) {
    final updatedParkingSpace = ParkingSpace.fromJson(value.payload).toDto();
    final event = value.events.firstOrNull?.split('.').lastOrNull ?? '';
    final parkingSpaceDtos = isar.parkingSpaceDtos;

    switch (event) {
      case update:
        final existingParkingSpace = parkingSpaceDtos
            .filter()
            .areaEqualTo(updatedParkingSpace.area)
            .and()
            .numberEqualTo(updatedParkingSpace.number)
            .build()
            .findFirstSync();

        if (existingParkingSpace != null) {
          isar.writeTxnSync(
              () => parkingSpaceDtos.putSync(updatedParkingSpace..localID = existingParkingSpace.localID));
        }
      case create:
        isar.writeTxnSync(() => parkingSpaceDtos.putSync(updatedParkingSpace));
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
