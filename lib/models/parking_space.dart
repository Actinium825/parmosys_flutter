import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parmosys_flutter/utils/strings.dart';

part 'parking_space.freezed.dart';
part 'parking_space.g.dart';

@freezed
class ParkingSpace with _$ParkingSpace {
  const factory ParkingSpace({
    @JsonKey(name: '\$id') String? id,
    @JsonKey(name: '\$collectionId') String? collectionId,
    @JsonKey(name: 'availability') bool? isAvailable,
  }) = _ParkingSpace;

  factory ParkingSpace.fromJson(Map<String, dynamic> json) => _$ParkingSpaceFromJson(json);
}
