import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/models/parking_area.dart';

final selectedAreaProvider = StateProvider.autoDispose<ParkingArea>((_) => const ParkingArea());
