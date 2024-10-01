import 'package:flutter/material.dart';

class VerticalSpace extends StatelessWidget {
  const VerticalSpace({
    required this.space,
    super.key,
  });

  final double space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: space);
  }
}

class HorizontalSpace extends StatelessWidget {
  const HorizontalSpace({
    required this.space,
    super.key,
  });

  final double space;

  @override
  Widget build(BuildContext context) {
    return SizedBox(width: space);
  }
}
