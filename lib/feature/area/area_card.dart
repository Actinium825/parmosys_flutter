import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/area/area_count_label.dart';
import 'package:parmosys_flutter/models/parking_area.dart';
import 'package:parmosys_flutter/providers/selected_area_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/router.dart';
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

  void _onSelectArea(BuildContext context, WidgetRef ref) {
    ref.watch(selectedAreaProvider.notifier).state = ParkingArea(area, imageUrl);
    ParkingSpaceRoute().push<void>(context);
  }

  bool _isAcronym() {
    final letters = area.split('');
    return letters.every((letter) => letter == letter.toUpperCase());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bold = TextStyles.bold.copyWith(letterSpacing: _isAcronym() ? 10 : null);
    return Card(
      color: _cardColor(context),
      elevation: defaultElevation,
      child: InkWell(
        onTap: () => _onSelectArea(context, ref),
        borderRadius: BorderRadius.circular(areaCardRadius),
        child: Padding(
          padding: areaCardPadding,
          child: Stack(
            children: [
              if (isSelected)
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    area,
                    style: bold,
                  ),
                ),
              Center(
                child: Hero(
                  tag: area,
                  child: Image.asset(imageUrl),
                ),
              ),
              Align(
                alignment: isSelected ? Alignment.bottomRight : Alignment.bottomCenter,
                child: isSelected
                    ? AreaCountLabel(
                        area: area,
                        style: TextStyles.medium.copyWith(fontSize: 12.0),
                      )
                    : Text(
                        area,
                        style: bold,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
