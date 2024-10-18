import 'package:isar/isar.dart';
import 'package:parmosys_flutter/models/dto/parking_space_dto.dart';
import 'package:parmosys_flutter/providers/app_documents_directory_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'isar_provider.g.dart';

@riverpod
Isar isarInstance(IsarInstanceRef ref) =>
    Isar.getInstance() ??
    Isar.openSync(
      [ParkingSpaceDtoSchema],
      directory: ref.read(appDocumentsDirectoryProvider).path,
    );
