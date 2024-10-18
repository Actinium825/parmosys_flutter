import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/utils/enums.dart';

final selectedCategoryProvider = StateProvider.autoDispose<ParkingCategory?>((_) => null);
