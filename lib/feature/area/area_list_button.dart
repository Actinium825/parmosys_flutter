import 'package:flutter/material.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class AreaListButton extends StatelessWidget {
  const AreaListButton({
    required this.area,
    required this.imageUrl,
    super.key,
  });

  final String area;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(areaListButtonRadius);
    return Card(
      color: areaListButtonColor,
      elevation: defaultElevation,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      margin: EdgeInsets.zero,
      child: InkWell(
        // TODO: Add function
        onTap: () {},
        borderRadius: borderRadius,
        splashColor: lightBackgroundColor,
        child: Padding(
          padding: areaListButtonPadding,
          child: Row(
            children: [
              Image.asset(
                imageUrl,
                scale: areaListImageScale,
              ),
              const HorizontalSpace(space: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    area,
                    style: TextStyles.semiBold.copyWith(letterSpacing: 4.0),
                  ),
                  const VerticalSpace(space: 4.0),
                  // TODO: Update value
                  Text(
                    availableSpotLabel,
                    style: TextStyles.light,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
