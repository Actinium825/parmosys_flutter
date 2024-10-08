import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/parking_space/spot_list.dart';
import 'package:parmosys_flutter/feature/parking_space/state_text.dart';
import 'package:parmosys_flutter/feature/parmosys_drawer/parmosys_drawer.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/providers/selected_area_provider.dart';
import 'package:parmosys_flutter/providers/parking_spaces_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';
import 'package:sprintf/sprintf.dart';

class ParkingSpacePage extends ConsumerStatefulWidget {
  const ParkingSpacePage({super.key});

  static const route = 'parking-space';

  @override
  ConsumerState<ParkingSpacePage> createState() => _ParkingSpacePageState();
}

class _ParkingSpacePageState extends ConsumerState<ParkingSpacePage> {
  @override
  void initState() {
    ref.read(parkingSpacesProvider.notifier).getDocuments();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedArea = ref.watch(selectedAreaProvider);
    final parkingSpacesValue = ref.watch(parkingSpacesProvider);
    final extraBold = TextStyles.extraBold;
    final imageUrl = selectedArea.imageUrl;
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
                          sprintf(availableSpotLabel, [ref.watch(parkingSpacesProvider.notifier).availableCount()]),
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
            Container(
              decoration: decoration,
              padding: parkingSpaceCardPadding,
              child: parkingSpacesValue.when(
                data: (parkingSpaces) {
                  final totalCount = parkingSpaces.length;
                  final leftCount = (totalCount / 2).ceil();
                  final divider = SizedBox(
                    height: leftCount * yellowDividerHeightMultiplier,
                    child: const VerticalDivider(
                      color: parkingYellow,
                      thickness: yellowDividerThickness,
                    ),
                  );

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SpotList(
                        parkingSpaces: parkingSpaces.sublist(0, leftCount),
                        divider: divider,
                      ),
                      divider,
                      SpotList(
                        alignment: Alignment.topRight,
                        divider: divider,
                        initialSpotCount: leftCount,
                        parkingSpaces: parkingSpaces.sublist(leftCount),
                      ),
                    ],
                  );
                },
                error: (_, __) => const StateText(label: noDataLabel),
                loading: () => const StateText(label: loadingLabel),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
