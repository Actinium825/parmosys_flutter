import 'package:flutter/material.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    required this.label,
    required this.image,
    this.imageSize = collegesImageSize,
    this.imageTopPosition = 24.0,
    this.imageLeftPosition,
    super.key,
  });

  final String label;
  final String image;
  final double imageSize;
  final double imageTopPosition;
  final double? imageLeftPosition;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(categoryButtonRadius);
    final isDarkMode = context.isDarkMode;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: categoryButtonHeight,
          width: categoryButtonWidth,
          child: InkWell(
            // TODO: Add function
            onTap: () {},
            borderRadius: borderRadius,
            splashColor: categoryPageBackgroundColor,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: categoryButtonBackgroundHeight,
                  width: categoryButtonBackgroundWidth,
                  decoration: BoxDecoration(
                    color: isDarkMode ? categoryButtonDarkColor : categoryButtonLightColor,
                    borderRadius: borderRadius,
                  ),
                ),
                Positioned(
                  top: imageTopPosition,
                  left: imageLeftPosition,
                  child: Image.asset(
                    image,
                    width: imageSize,
                    height: imageSize,
                  ),
                ),
              ],
            ),
          ),
        ),
        const VerticalSpace(space: 8.0),
        Text(
          label,
          style: TextStyles.bold.copyWith(color: isDarkMode ? Colors.white : categoryButtonLightColor),
        )
      ],
    );
  }
}
