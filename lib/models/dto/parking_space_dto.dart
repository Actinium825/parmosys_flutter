import 'package:isar/isar.dart';

part 'parking_space_dto.g.dart';

@collection
class ParkingSpaceDto {
  Id? localID;

  late int number;
  late String area;
  late bool isAvailable;

  ParkingSpaceDto({
    this.number = 1,
    this.area = '',
    this.isAvailable = false,
  });
}
