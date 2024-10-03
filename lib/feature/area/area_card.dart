import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';

class AreaCard extends ConsumerWidget {
  const AreaCard({
    required this.isSelected,
    required this.area,
    required this.imageUrl,
    super.key,
  });

  final String area;
  final String imageUrl;
  final bool isSelected;

  Color _cardColor(BuildContext context) {
    if (!isSelected) return cardButtonDarkColor;
    return context.isDarkMode ? darkBackgroundColor : lightBackgroundColor;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      color: _cardColor(context),
      elevation: areaCardElevation,
      child: Padding(
        padding: areaCardPadding,
        child: Stack(
          children: [
            if (isSelected)
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  area,
                  style: TextStyles.bold,
                ),
              ),
            Center(child: Image.asset(imageUrl)),
            Align(
              alignment: isSelected ? Alignment.bottomRight : Alignment.bottomCenter,
              child: Text(
                // TODO: Update value
                isSelected ? availableSpotLabel : area,
                style: isSelected ? TextStyles.medium.copyWith(fontSize: 12.0) : TextStyles.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
