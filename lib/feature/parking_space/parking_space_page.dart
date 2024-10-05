import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/parmosys_drawer/parmosys_drawer.dart';
import 'package:parmosys_flutter/providers/selected_area_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';

class ParkingSpacePage extends ConsumerWidget {
  const ParkingSpacePage({super.key});

  static const route = 'parking-space';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final extraBold = TextStyles.extraBold;
    final selectedArea = ref.watch(selectedAreaProvider);
    final imageUrl = selectedArea.imageUrl;

    return Scaffold(
      backgroundColor: context.isDarkMode ? darkBackgroundColor : lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actionsIconTheme: appBarIconTheme,
        iconTheme: appBarIconTheme,
      ),
      endDrawer: const ParmosysDrawer(),
      body: Column(
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
          )
        ],
      ),
    );
  }
}
