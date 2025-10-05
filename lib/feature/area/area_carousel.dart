import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/area/area_card.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/enums.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class AreaCarousel extends ConsumerStatefulWidget {
  const AreaCarousel({
    required this.selectedCategory,
    super.key,
  });

  final ParkingCategory selectedCategory;

  @override
  ConsumerState<AreaCarousel> createState() => _AreaCarouselState();
}

class _AreaCarouselState extends ConsumerState<AreaCarousel> {
  late final _currentIndexNotifier = ValueNotifier(0);

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const verticalSpaceLarge = VerticalSpace(space: 64.0);
    final areas = widget.selectedCategory.areas;
    final areaCount = areas.length;

    return Column(
      children: [
        FlutterCarousel.builder(
          itemCount: areaCount,
          itemBuilder: (_, index, _) => AreaCard(
            isSelected: _currentIndexNotifier.value == index,
            area: areas[index],
            imageUrl: widget.selectedCategory.cardAreaImageUrl(index),
          ),
          options: FlutterCarouselOptions(
            viewportFraction: carouselViewportFraction,
            aspectRatio: carouselAspectRatio,
            enlargeFactor: carouselEnlargeFactor,
            enlargeCenterPage: true,
            showIndicator: false,
            onPageChanged: (index, _) => _currentIndexNotifier.value = index,
          ),
        ),
        verticalSpaceLarge,
        Container(
          alignment: Alignment.center,
          width: carouselIndicatorWidth,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              areaCount,
              (index) => ValueListenableBuilder<int>(
                valueListenable: _currentIndexNotifier,
                builder: (_, currentIndex, _) => CircleAvatar(
                  radius: carouselIndicatorRadius,
                  backgroundColor: currentIndex == index ? activeIndicatorColor : inactiveIndicatorColor,
                ),
              ),
            ),
          ),
        ),
        verticalSpaceLarge,
        Text(
          swipeToSelectLabel,
          textAlign: TextAlign.center,
          style: TextStyles.medium.copyWith(color: context.isDarkMode ? Colors.white : Colors.black),
        ),
      ],
    );
  }
}
