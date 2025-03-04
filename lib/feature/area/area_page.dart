import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/feature/area/area_body.dart';
import 'package:parmosys_flutter/feature/area/area_count_label.dart';
import 'package:parmosys_flutter/providers/appwrite_stream_provider.dart';
import 'package:parmosys_flutter/providers/firebase_stream_provider.dart';
import 'package:parmosys_flutter/providers/parking_spaces_provider.dart';
import 'package:parmosys_flutter/providers/selected_category_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/enums.dart';
import 'package:parmosys_flutter/utils/env.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/parmosys_scaffold.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class AreaPage extends ConsumerWidget {
  const AreaPage({super.key});

  static const route = 'area';

  void _realtimeListener(WidgetRef ref) {
    switch (Env.database) {
      case firebase:
        final selectedCategory = ref.read(selectedCategoryProvider);
        final areas = [...?selectedCategory?.areas];

        for (final area in areas) {
          ref.listen(
            firebaseStreamProvider(area.toSnakeCase()),
            (_, next) => next.whenData(
              (value) {
                final docChanges = value.docChanges;
                for (final docChange in docChanges) {
                  final data = {...?docChange.doc.data()};
                  final event = docChange.type.toEventString();

                  ref.read(parkingSpacesProvider().notifier).updateParkingSpace(data, event);
                }
              },
            ),
          );
        }
      case appwrite:
        ref.listen(
          appwriteStreamProvider,
          (_, next) => next.whenData(
            (value) {
              final event = value.events.firstOrNull?.split('.').lastOrNull ?? '';
              final data = value.payload;

              ref.read(parkingSpacesProvider().notifier).updateParkingSpace(data, event);
            },
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategory = ref.read(selectedCategoryProvider) ?? ParkingCategory.colleges;
    final imageUrl = selectedCategory.imageUrl;
    final color = context.isDarkMode ? Colors.white : Colors.black;
    const verticalSpace = VerticalSpace(space: 16.0);

    _realtimeListener(ref);

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
                      AreaCountLabel(
                        label: totalAvailableSpotLabel,
                        style: TextStyles.regular.copyWith(color: color),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          verticalSpace,
          const AreaBody(),
          verticalSpace,
        ],
      ),
    );
  }
}
