import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parmosys_flutter/feature/parking_space/yellow_divider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';

class SpotList extends StatelessWidget {
  const SpotList({
    // TODO: Update value
    this.spaceCount = 6,
    this.alignment = Alignment.topLeft,
    super.key,
  });

  final Alignment alignment;
  final int spaceCount;

  @override
  Widget build(BuildContext context) {
    final isLeft = alignment == Alignment.topLeft;
    return Expanded(
      child: Stack(
        alignment: alignment,
        children: [
          YellowDivider(multiplier: spaceCount),
          Positioned(
            left: isLeft ? spotListPosition : null,
            right: isLeft ? null : spotListPosition,
            child: SizedBox(
              width: spotListWidth,
              child: ListView.builder(
                padding: spotListPadding,
                itemCount: spaceCount,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final count = index + 1;
                  return Transform.rotate(
                    angle: (isLeft ? pi : -pi) / spotListBaseAngle,
                    child: Column(
                      crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        Text(
                          // TODO: Replace with sprintf
                          '$spotLabel $count',
                          style: TextStyles.bold.copyWith(fontSize: 24.0),
                        ),
                        SizedBox(
                          width: count < spaceCount ? spotListWidth : 0,
                          child: const Divider(
                            color: parkingYellow,
                            thickness: yellowDividerThickness,
                            height: spotHeight,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
