import 'package:appwrite/appwrite.dart';
import 'package:dartx/dartx.dart';
import 'package:parmosys_flutter/models/parking_space.dart';
import 'package:parmosys_flutter/utils/env.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'parking_spaces_provider.g.dart';

@riverpod
class ParkingSpaces extends _$ParkingSpaces {
  @override
  AsyncValue<List<ParkingSpace>> build() => const AsyncLoading();

  void getDocuments() async {
    try {
      final results = await _initDatabase.listDocuments(databaseId: Env.databaseId, collectionId: Env.collectedId);

      state = AsyncValue.data(
        results.documents
            .map((document) => ParkingSpace.getNumber(document.data))
            .sortedBy((parkingSpace) => parkingSpace.number),
      );

      _initParkingSpaceSubscription();
    } on AppwriteException catch (error, stack) {
      state = AsyncError(error, stack);
    }
  }

  void _updateParkingSpace(ParkingSpace updatedParkingSpace) {
    final updatedParkingSpaces = state.value
        ?.map((parkingSpace) => parkingSpace.number == updatedParkingSpace.number ? updatedParkingSpace : parkingSpace);

    state = AsyncValue.data([...?updatedParkingSpaces]);
  }

  Databases get _initDatabase {
    final client = Client()
      ..setEndpoint(Env.endpoint)
      ..setProject(Env.projectId);

    return Databases(client);
  }

  void _initParkingSpaceSubscription() {
    final realtime = Realtime(_initDatabase.client);
    // TODO: Replace with sprintf
    final subscription = realtime.subscribe(['databases.${Env.databaseId}.collections.${Env.collectedId}.documents']);

    subscription.stream.listen((data) => _updateParkingSpace(ParkingSpace.getNumber(data.payload)));
  }
}
