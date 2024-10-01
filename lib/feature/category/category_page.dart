import 'package:flutter/material.dart';
import 'package:parmosys_flutter/feature/category/widgets/category_button.dart';
import 'package:parmosys_flutter/feature/parmosys_drawer/parmosys_drawer.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  static const route = '/category-page';

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(searchTextRadius);
    final extraBold = TextStyles.extraBold;
    final isDarkMode = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDarkMode ? homeBackgroundColor : categoryPageBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        actionsIconTheme: const IconThemeData(color: Colors.white),
      ),
      endDrawer: const ParmosysDrawer(),
      body: Column(
        children: [
          Padding(
            padding: categoryPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryPageHeader.first,
                  style: extraBold,
                ),
                Row(
                  children: [
                    Text(
                      categoryPageHeader[1],
                      style: extraBold,
                    ),
                    const Icon(
                      Icons.location_on_rounded,
                      color: locationButtonColor,
                      size: locationIconSize,
                    ),
                  ],
                ),
                const VerticalSpace(space: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    borderRadius: borderRadius,
                  ),
                  height: searchTextHeight,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: hintTextLabel,
                      hintStyle: TextStyles.light,
                      border: OutlineInputBorder(borderRadius: borderRadius),
                      contentPadding: hintTextPadding,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const VerticalSpace(space: 80.0),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset(
              Assets.png.lancerSide.path,
              scale: lancerSideImageScale,
            ),
          ),
          Expanded(
            child: Card(
              color: isDarkMode ? categoryPageBottomSheetDarkColor : Colors.white,
              shape: categoryPageBottomSheetShape,
              margin: EdgeInsets.zero,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CategoryButton(
                    label: collegesLabel,
                    image: Assets.png.colleges.path,
                  ),
                  CategoryButton(
                    label: hallsLabel,
                    image: Assets.png.halls.path,
                    imageSize: hallsImageSize,
                    imageLeftPosition: 28.0,
                  ),
                  CategoryButton(
                    label: recreationalLabel,
                    image: Assets.png.recreational.path,
                    imageSize: recreationalImageSize,
                    imageLeftPosition: 20.0,
                    imageTopPosition: 16.0,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
