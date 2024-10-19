import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/providers/available_spots_provider.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:sprintf/sprintf.dart';

class AreaCountLabel extends ConsumerWidget {
  const AreaCountLabel({
    required this.style,
    this.label = availableSpotLabel,
    this.area,
    super.key,
  });

  final TextStyle style;
  final String label;
  final String? area;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(availableSpotsProvider(area?.toSnakeCase()));
    return Text(
      sprintf(label, [count]),
      style: style,
    );
  }
}
