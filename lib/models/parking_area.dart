import 'package:freezed_annotation/freezed_annotation.dart';

part 'parking_area.freezed.dart';

@freezed
class ParkingArea with _$ParkingArea {
  const factory ParkingArea([
    @Default('') String header,
    @Default('') String imageUrl,
  ]) = _ParkingArea;
}
