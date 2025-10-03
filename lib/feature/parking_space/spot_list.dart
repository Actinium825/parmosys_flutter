import 'dart:math';

import 'package:flutter/material.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/models/dto/parking_space_dto.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:sprintf/sprintf.dart';

class SpotList extends StatelessWidget {
  const SpotList({
    required this.parkingSpaces,
    required this.divider,
    this.alignment = Alignment.topLeft,
    super.key,
  });

  final List<ParkingSpaceDto> parkingSpaces;
  final Alignment alignment;
  final Widget divider;

  @override
  Widget build(BuildContext context) {
    final isLeft = alignment == Alignment.topLeft;
    final parkingSpacesCount = parkingSpaces.length;

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
                itemCount: parkingSpacesCount,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  final parkingSpace = parkingSpaces[index];
                  return Transform.rotate(
                    angle: (isLeft ? pi : -pi) / spotListBaseAngle,
                    child: Column(
                      crossAxisAlignment: isLeft ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                      children: [
                        if (parkingSpace.isAvailable)
                          Text(
                            sprintf(spotLabel, [parkingSpace.number]),
                            style: TextStyles.bold.copyWith(fontSize: 24.0),
                          )
                        else
                          Transform.rotate(
                            angle: isLeft ? 0 : pi,
                            child: Image.asset(
                              Assets.png.car.path,
                              scale: spotCarImageScale,
                            ),
                          ),
                        SizedBox(
                          width: index + 1 < parkingSpacesCount ? spotListWidth : 0,
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
