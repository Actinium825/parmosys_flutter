import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parmosys_flutter/feature/area/area_page.dart';
import 'package:parmosys_flutter/feature/category/category_button.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/providers/selected_category_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/enums.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/widgets/parmosys_scaffold.dart';

class CategoryPage extends ConsumerWidget {
  const CategoryPage({super.key});

  static const route = '/category';

  void _onSelectCategory(BuildContext context, WidgetRef ref, ParkingCategory parkingCategory) {
    ref.watch(selectedCategoryProvider.notifier).state = parkingCategory;
    context.pushNamed(AreaPage.route);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ParmosysScaffold(
      header: categoryPageHeader,
      body: Expanded(
        child: Align(
          alignment: Alignment.centerRight,
          child: Image.asset(
            Assets.png.lancerSide.path,
            width: MediaQuery.of(context).size.width * lancerSideImageMultiplier,
          ),
        ),
      ),
      cardBody: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryButton(
            parkingCategory: ParkingCategory.colleges,
            onTap: (parkingCategory) => _onSelectCategory(context, ref, parkingCategory),
          ),
          CategoryButton(
            parkingCategory: ParkingCategory.halls,
            imageSize: hallsImageSize,
            imageLeftPosition: 28.0,
            onTap: (parkingCategory) => _onSelectCategory(context, ref, parkingCategory),
          ),
          CategoryButton(
            parkingCategory: ParkingCategory.recreational,
            imageSize: recreationalImageSize,
            imageLeftPosition: 20.0,
            imageTopPosition: 16.0,
            onTap: (parkingCategory) => _onSelectCategory(context, ref, parkingCategory),
          ),
        ],
      ),
    );
  }
}
