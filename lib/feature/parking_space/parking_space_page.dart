import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/parking_space/spot_list.dart';
import 'package:parmosys_flutter/feature/parking_space/yellow_divider.dart';
import 'package:parmosys_flutter/feature/parmosys_drawer/parmosys_drawer.dart';
import 'package:parmosys_flutter/providers/selected_area_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class ParkingSpacePage extends ConsumerWidget {
  const ParkingSpacePage({super.key});

  static const route = 'parking-space';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extraBold = TextStyles.extraBold;
    final selectedArea = ref.watch(selectedAreaProvider);
    final imageUrl = selectedArea.imageUrl;
    final backgroundColor = context.isDarkMode ? darkBackgroundColor : lightBackgroundColor;

    return Scaffold(
      backgroundColor: bottomSheetDarkColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        actionsIconTheme: appBarIconTheme,
        iconTheme: appBarIconTheme,
      ),
      endDrawer: const ParmosysDrawer(),
      body: ListView(
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
                              selectedArea.header.toUpperCase(),
                              style: extraBold,
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Hero(
                              tag: imageUrl,
                              child: Image.asset(
                                imageUrl,
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
                        availableSpotLabel,
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
            foregroundDecoration: parkingSpaceBorderForegroundDecoration,
            decoration: BoxDecoration(color: backgroundColor),
          ),
          const ColoredBox(
            // TODO: Update texture
            color: bottomSheetDarkColor,
            child: Padding(
              padding: parkingSpaceCardPadding,
              child: Row(
                children: [
                  SpotList(),
                  YellowDivider(multiplier: 6),
                  SpotList(alignment: Alignment.topRight),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
