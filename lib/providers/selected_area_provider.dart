import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/models/parking_area_model.dart';

final selectedAreaProvider = StateProvider.autoDispose<ParkingArea>((ref) => const ParkingArea());
