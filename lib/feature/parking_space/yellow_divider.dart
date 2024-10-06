import 'package:flutter/material.dart';
import 'package:parmosys_flutter/utils/const.dart';

class YellowDivider extends StatelessWidget {
  const YellowDivider({
    required this.multiplier,
    super.key,
  });

  final int multiplier;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: multiplier * yellowDividerHeightMultiplier,
      child: const VerticalDivider(
        color: parkingYellow,
        thickness: yellowDividerThickness,
      ),
    );
  }
}
