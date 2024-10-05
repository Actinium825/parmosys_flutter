import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/area/area_card.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/providers/selected_category_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/enums.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/parmosys_scaffold.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class AreaPage extends ConsumerStatefulWidget {
  const AreaPage({super.key});

  static const route = 'area';

  @override
  ConsumerState<AreaPage> createState() => _AreaPageState();
}

class _AreaPageState extends ConsumerState<AreaPage> {
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

  String _areaImageUrl(int index, ParkingCategory selectedCategory) {
    const png = Assets.png;
    return switch (selectedCategory) {
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
    final selectedCategory = ref.watch(selectedCategoryProvider.notifier).state ?? ParkingCategory.colleges;
    final areas = selectedCategory.areas;
    final areaCount = areas.length;
    final imageUrl = selectedCategory.imageUrl;
    final color = context.isDarkMode ? Colors.white : Colors.black;
    const verticalSpaceLarge = VerticalSpace(space: 64.0);
    const verticalSpaceSmall = VerticalSpace(space: 16.0);

    return ParmosysScaffold(
      header: areaPageHeaders,
      body: const VerticalSpace(space: 40.0),
      isBackButtonShown: true,
      cardRadius: areaPageCardRadius,
      cardBody: ListView(
        padding: EdgeInsets.zero,
        children: [
          const VerticalSpace(space: 32.0),
          Padding(
            padding: EdgeInsets.only(
              left: selectedCategory != ParkingCategory.halls ? 0 : areaPagePadding,
              right: areaPagePadding,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: imageUrl,
                  child: Image.asset(
                    imageUrl,
                    scale: areaPageHeaderImageScale,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedCategory.header.toUpperCase(),
                        style: TextStyles.extraBold.copyWith(
                          color: color,
                          overflow: TextOverflow.ellipsis,
                          fontSize: 32.0,
                          letterSpacing: areaPageHeaderSpacing,
                        ),
                      ),
                      Text(
                        // TODO: Update value
                        totalAvailableSpotLabel,
                        style: TextStyles.regular.copyWith(color: color),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          verticalSpaceSmall,
          FlutterCarousel.builder(
            itemCount: areaCount,
            itemBuilder: (_, index, __) => AreaCard(
              isSelected: _currentIndexNotifier.value == index,
              area: areas[index],
              imageUrl: _areaImageUrl(index, selectedCategory),
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
            style: TextStyles.medium.copyWith(color: color),
          ),
          verticalSpaceSmall,
        ],
      ),
    );
  }
}
