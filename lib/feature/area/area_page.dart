import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/providers/selected_category_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/enums.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/parmosys_scaffold.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class AreaPage extends ConsumerWidget {
  const AreaPage({super.key});

  static const route = 'area';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.watch(selectedCategoryProvider.notifier).state ?? ParkingCategory.colleges;
    final imageUrl = selectedCategory.imageUrl;
    final isDarkMode = context.isDarkMode;
    const verticalSpace = VerticalSpace(space: 32.0);
    final color = isDarkMode ? Colors.white : Colors.black;

    return ParmosysScaffold(
      header: areaPageHeaders,
      body: const VerticalSpace(space: 40.0),
      isBackButtonShown: true,
      cardRadius: areaPageCardRadius,
      cardBody: Padding(
        padding: EdgeInsets.only(
          left: selectedCategory != ParkingCategory.halls ? 0 : areaPagePadding,
          right: areaPagePadding,
        ),
        child: Column(
          children: [
            verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: imageUrl,
                  child: Image.asset(
                    imageUrl,
                    scale: areaPageHeaderImageScale,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedCategory.header.toUpperCase(),
                        style: TextStyles.extraBold.copyWith(
                          color: color,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 32.0,
                          letterSpacing: areaPageHeaderSpacing,
                        ),
                      ),
                      Text(
                        // TODO: Update value
                        availableSpotLabel,
                        style: TextStyles.regular.copyWith(color: color),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              swipeToSelectLabel,
              style: TextStyles.medium,
            ),
            verticalSpace,
          ],
        ),
      ),
    );
  }
}
