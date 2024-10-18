import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/providers/available_spots_stream_provider.dart';

final availableSpotsProvider = Provider.autoDispose.family<int, String?>((ref, area) {
  final availableSpotsStream = ref.watch(availableSpotsStreamProvider(area));

  return availableSpotsStream.maybeWhen(
    data: (data) => data.length,
    orElse: () => 0,
  );
});
