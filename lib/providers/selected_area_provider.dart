import 'package:flutter_riverpod/legacy.dart';
import 'package:parmosys_flutter/models/parking_area.dart';

final selectedAreaProvider = StateProvider.autoDispose<ParkingArea>((_) => const ParkingArea());
