import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';

class SpotList extends StatelessWidget {
  const SpotList({
    required this.spaceCount,
    required this.divider,
    this.alignment = Alignment.topLeft,
    this.initialSpotCount,
    super.key,
  });

  final Alignment alignment;
  final Widget divider;
  final int spaceCount;
  final int? initialSpotCount;

  @override
  Widget build(BuildContext context) {
    final isLeft = alignment == Alignment.topLeft;
    return Expanded(
      child: Stack(
        alignment: alignment,
        children: [
          divider,
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
                  final increment = index + 1;
                  final spotNumber = increment + (initialSpotCount ?? 0);

                  return Transform.rotate(
                    angle: (isLeft ? pi : -pi) / spotListBaseAngle,
                    child: Column(
                      crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        Text(
                          // TODO: Replace with sprintf
                          '$spotLabel $spotNumber',
                          style: TextStyles.bold.copyWith(fontSize: 24.0),
                        ),
                        SizedBox(
                          width: increment < spaceCount ? spotListWidth : 0,
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
