import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/parking_space/spot_list.dart';
import 'package:parmosys_flutter/providers/parking_spaces_provider.dart';
import 'package:parmosys_flutter/providers/selected_area_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';

class ParkingSpaceCard extends ConsumerWidget {
  const ParkingSpaceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedArea = ref.read(selectedAreaProvider);
    final parkingSpacesValue = ref.watch(parkingSpacesProvider(selectedArea.header.toSnakeCase()));

    return parkingSpacesValue.maybeWhen(
      data: (parkingSpaces) {
        if (parkingSpaces.isEmpty) {
          return Center(
            child: Text(
              noDataLabel,
              style: TextStyles.bold.copyWith(fontSize: 24.0),
            ),
          );
        }

        final totalCount = parkingSpaces.length;
        final leftCount = (totalCount / 2).ceil();
        final divider = SizedBox(
          height: leftCount * yellowDividerHeightMultiplier,
          child: const VerticalDivider(
            color: parkingYellow,
            thickness: yellowDividerThickness,
          ),
        );

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SpotList(
              parkingSpaces: parkingSpaces.sublist(0, leftCount),
              divider: divider,
            ),
            divider,
            SpotList(
              alignment: Alignment.topRight,
              divider: divider,
              initialSpotCount: leftCount,
              parkingSpaces: parkingSpaces.sublist(leftCount),
            ),
          ],
        );
      },
      orElse: () => Center(
        child: Text(
          noDataLabel,
          style: TextStyles.bold.copyWith(fontSize: 24.0),
        ),
      ),
    );
  }
}
