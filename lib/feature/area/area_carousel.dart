import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/area/area_card.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
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
  late final ValueNotifier<int> _currentIndexNotifier;

  @override
  void initState() {
    _currentIndexNotifier = ValueNotifier(0);
    super.initState();
  }

  @override
  void dispose() {
    _currentIndexNotifier.dispose();
    super.dispose();
  }

  String _areaImageUrl(int index) {
    const png = Assets.png;
    return switch (widget.selectedCategory) {
      ParkingCategory.colleges => [png.chtm.path, png.cict.path, png.law.path, png.cssp.path][index],
      ParkingCategory.halls => png.hall.path,
      ParkingCategory.recreational => [
          png.activityCenter.path,
          png.heroesPark.path,
          png.library.path,
          png.universityHostel.path
        ][index],
    };
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
          itemBuilder: (_, index, __) => AreaCard(
            isSelected: _currentIndexNotifier.value == index,
            area: areas[index],
            imageUrl: _areaImageUrl(index),
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
        Center(
          child: SizedBox(
            width: carouselIndicatorWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                areaCount,
                (index) => ValueListenableBuilder<int>(
                  valueListenable: _currentIndexNotifier,
                  builder: (_, currentIndex, __) => CircleAvatar(
                    radius: carouselIndicatorRadius,
                    backgroundColor: currentIndex == index ? activeIndicatorColor : inactiveIndicatorColor,
                  ),
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
