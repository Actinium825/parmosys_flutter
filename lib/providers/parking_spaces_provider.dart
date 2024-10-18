import 'package:appwrite/appwrite.dart';
import 'package:dartx/dartx.dart';
import 'package:parmosys_flutter/models/parking_space.dart';
import 'package:parmosys_flutter/utils/env.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parking_spaces_provider.g.dart';

@Riverpod(keepAlive: true)
class ParkingSpaces extends _$ParkingSpaces {
  @override
  AsyncValue<List<ParkingSpace>> build() => const AsyncData([]);

  final _documents = <ParkingSpace>[];

  void getAllDocuments() async {
    state = const AsyncLoading();

    final areas = [...collegesAreas, ...hallsAreas, ...recreationalAreas];
    final client = Client()
      ..setEndpoint(Env.endpoint)
      ..setProject(Env.projectId);
    final database = Databases(client);
    final futures = <Future<void>>[];

    for (final area in areas) {
      futures.add(getDocuments(database, area.toSnakeCase()));
    }

    try {
      await Future.wait(futures);
    } catch (error, stack) {
      state = AsyncError(error, stack);
    }

    state = AsyncValue.data(_documents);
  }

  Future<void> getDocuments(Databases database, String collectionId) async {
    final results = await database.listDocuments(databaseId: Env.databaseId, collectionId: collectionId);

    for (final document in results.documents) {
      _documents.add(ParkingSpace.getNumber(document.data));
    }
  }

  void updateParkingSpace(RealtimeMessage value) {
    final updatedParkingSpace = ParkingSpace.getNumber(value.payload);
    final event = value.events.firstOrNull?.split('.').lastOrNull ?? '';
    final currentParkingSpaces = [...?state.value];

    switch (event) {
      case update:
        final updatedParkingSpaces = currentParkingSpaces
            .map((parkingSpace) => parkingSpace.isMatch(updatedParkingSpace) ? updatedParkingSpace : parkingSpace)
            .toList();

        state = AsyncValue.data(updatedParkingSpaces);
      case create:
        state = AsyncValue.data([...currentParkingSpaces, updatedParkingSpace]);
      case delete:
        final updatedParkingSpaces =
            currentParkingSpaces.filterNot((parkingSpace) => parkingSpace.isMatch(updatedParkingSpace)).toList();

        state = AsyncValue.data(updatedParkingSpaces);
    }
  }
}
