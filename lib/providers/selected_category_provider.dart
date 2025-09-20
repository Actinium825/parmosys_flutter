import 'package:flutter_riverpod/legacy.dart';
import 'package:parmosys_flutter/utils/enums.dart';

final selectedCategoryProvider = StateProvider.autoDispose<ParkingCategory?>((_) => null);
