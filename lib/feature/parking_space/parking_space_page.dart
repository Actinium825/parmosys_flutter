import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/parking_space/parking_space_card.dart';
import 'package:parmosys_flutter/feature/parmosys_drawer/parmosys_drawer.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/providers/available_spots_provider.dart';
import 'package:parmosys_flutter/providers/selected_area_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';
import 'package:sprintf/sprintf.dart';

class ParkingSpacePage extends ConsumerWidget {
  const ParkingSpacePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedArea = ref.watch(selectedAreaProvider);
    final extraBold = TextStyles.extraBold;
    final header = selectedArea.header;
    final backgroundColor = context.isDarkMode ? darkBackgroundColor : lightBackgroundColor;
    final decoration = BoxDecoration(
      image: DecorationImage(
        repeat: ImageRepeat.repeat,
        image: AssetImage(Assets.png.grain.path),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        actionsIconTheme: appBarIconTheme,
        iconTheme: appBarIconTheme,
      ),
      endDrawer: const ParmosysDrawer(),
      body: DecoratedBox(
        decoration: decoration,
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            ColoredBox(
              color: backgroundColor,
              child: Column(
                children: [
                  Padding(
                    padding: parmosysScaffoldPadding,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                header.toUpperCase(),
                                style: extraBold,
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Hero(
                                tag: header,
                                child: Image.asset(
                                  selectedArea.imageUrl,
                                  scale: parkingSpaceImageScale,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          parkingSpaceSubLabel,
                          style: extraBold,
                        ),
                        Text(
                          sprintf(availableSpotLabel, [ref.watch(availableSpotsProvider(header.toSnakeCase()))]),
                          style: TextStyles.regular.copyWith(fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  const VerticalSpace(space: 16.0),
                ],
              ),
            ),
            Container(
              height: parkingSpaceBorderHeight,
              foregroundDecoration: decoration.copyWith(
                color: bottomSheetDarkColor,
                borderRadius: parkingSpaceBorderRadius,
              ),
              decoration: BoxDecoration(color: backgroundColor),
            ),
            DecoratedBox(
              decoration: decoration,
              child: const Padding(
                padding: parkingSpaceCardPadding,
                child: ParkingSpaceCard(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
