import 'package:flutter/material.dart';
import 'package:parmosys_flutter/utils/styles.dart';

class StateText extends StatelessWidget {
  const StateText({
    required this.label,
    super.key,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: TextStyles.bold.copyWith(fontSize: 24.0),
      ),
    );
  }
}
