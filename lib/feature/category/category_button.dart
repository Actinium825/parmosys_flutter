import 'package:flutter/material.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/enums.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class CategoryButton extends StatelessWidget {
  const CategoryButton({
    required this.parkingCategory,
    required this.onTap,
    this.imageSize = collegesImageSize,
    this.imageTopPosition = 24.0,
    this.imageLeftPosition,
    super.key,
  });

  final ParkingCategory parkingCategory;
  final double imageSize;
  final double imageTopPosition;
  final ValueChanged<ParkingCategory> onTap;
  final double? imageLeftPosition;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(categoryButtonRadius);
    final isDarkMode = context.isDarkMode;
    final imageUrl = parkingCategory.imageUrl;

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: categoryButtonHeight,
            width: categoryButtonWidth,
            child: InkWell(
              onTap: () => onTap(parkingCategory),
              borderRadius: borderRadius,
              splashColor: lightBackgroundColor,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: categoryButtonBackgroundHeight,
                    width: categoryButtonBackgroundWidth,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: isDarkMode ? cardButtonDarkColor : cardButtonLightColor,
                        borderRadius: borderRadius,
                      ),
                    ),
                  ),
                  Positioned(
                    top: imageTopPosition,
                    left: imageLeftPosition,
                    child: Hero(
                      tag: imageUrl,
                      child: Image.asset(
                        imageUrl,
                        width: imageSize,
                        height: imageSize,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const VerticalSpace(space: 8.0),
          Text(
            parkingCategory.header,
            style: TextStyles.bold.copyWith(color: isDarkMode ? Colors.white : cardButtonLightColor),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
