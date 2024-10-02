import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parmosys_flutter/feature/area/area_page.dart';
import 'package:parmosys_flutter/feature/category/widgets/category_button.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/widgets/parmosys_scaffold.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  static const route = '/category';

  void _onSelectCategory(BuildContext context) => context.pushNamed(AreaPage.route);

  @override
  Widget build(BuildContext context) {
    return ParmosysScaffold(
      header: categoryPageHeader,
      body: Container(
        padding: lancerSideImagePadding,
        alignment: Alignment.centerRight,
        child: Image.asset(
          Assets.png.lancerSide.path,
          scale: lancerSideImageScale,
        ),
      ),
      cardBody: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryButton(
            label: collegesLabel,
            image: Assets.png.colleges.path,
            onTap: () => _onSelectCategory(context),
          ),
          CategoryButton(
            label: hallsLabel,
            image: Assets.png.halls.path,
            imageSize: hallsImageSize,
            imageLeftPosition: 28.0,
            onTap: () => _onSelectCategory(context),
          ),
          CategoryButton(
            label: recreationalLabel,
            image: Assets.png.recreational.path,
            imageSize: recreationalImageSize,
            imageLeftPosition: 20.0,
            imageTopPosition: 16.0,
            onTap: () => _onSelectCategory(context),
          ),
        ],
      ),
    );
  }
}
