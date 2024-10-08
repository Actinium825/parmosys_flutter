import 'package:freezed_annotation/freezed_annotation.dart';

part 'parking_space.freezed.dart';
part 'parking_space.g.dart';

@freezed
class ParkingSpace with _$ParkingSpace {
  const factory ParkingSpace({
    @Default('') @JsonKey(name: '\$id') String id,
    @Default(true) @JsonKey(name: 'availability') bool isAvailable,
    @Default(1) int number,
  }) = _ParkingSpace;

  factory ParkingSpace.fromJson(Map<String, dynamic> json) => _$ParkingSpotFromJson(json);

  factory ParkingSpace.getNumber(Map<String, dynamic> data) {
    final parkingSpace = ParkingSpace.fromJson(data);
    final match = RegExp(digits).stringMatch(parkingSpace.id) ?? '';
    final number = int.tryParse(match) ?? 0;

    return parkingSpace.copyWith(number: number);
  }
}
