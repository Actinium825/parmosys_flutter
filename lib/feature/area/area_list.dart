import 'package:flutter/material.dart';
import 'package:parmosys_flutter/feature/area/area_list_button.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/enums.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class AreaList extends StatelessWidget {
  const AreaList({
    required this.selectedCategory,
    super.key,
  });

  final ParkingCategory selectedCategory;

  String _areaImageUrl(int index) {
    const png = Assets.png;
    return switch (selectedCategory) {
      ParkingCategory.colleges => [
          png.chtmFront.path,
          png.cictFront.path,
          png.lawFront.path,
          png.csspFront.path
        ][index],
      ParkingCategory.halls => png.hallFront.path,
      ParkingCategory.recreational => [
          png.activityCenterFront.path,
          png.heroesParkFront.path,
          png.libraryFront.path,
          png.universityHostelFront.path
        ][index],
    };
  }

  @override
  Widget build(BuildContext context) {
    final areas = selectedCategory.areas;
    return Padding(
      padding: areaListPadding,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  sortByLabel,
                  style: TextStyles.bold.copyWith(
                    color: context.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 12.0,
                  ),
                ),
                const HorizontalSpace(space: 4.0),
                const Icon(Icons.sort_rounded),
              ],
            ),
          ),
          const VerticalSpace(space: 28.0),
          ListView.separated(
            itemCount: areas.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            separatorBuilder: (_, index) => const VerticalSpace(space: 32.0),
            itemBuilder: (_, index) => AreaListButton(
              area: areas[index],
              imageUrl: _areaImageUrl(index),
            ),
          ),
        ],
      ),
    );
  }
}
