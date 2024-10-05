import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parmosys_flutter/feature/parking_space/parking_space_page.dart';
import 'package:parmosys_flutter/models/parking_area_model.dart';
import 'package:parmosys_flutter/providers/selected_area_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class AreaListButton extends ConsumerWidget {
  const AreaListButton({
    required this.area,
    required this.smallImageUrl,
    required this.cardImageUrl,
    super.key,
  });

  final String area;
  final String smallImageUrl;
  final String cardImageUrl;

  void _onSelectArea(BuildContext context, WidgetRef ref) {
    ref.watch(selectedAreaProvider.notifier).state = ParkingArea(area, cardImageUrl);
    context.pushNamed(ParkingSpacePage.route);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final borderRadius = BorderRadius.circular(areaListButtonRadius);
    return Card(
      color: areaListButtonColor,
      elevation: defaultElevation,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: () => _onSelectArea(context, ref),
        borderRadius: borderRadius,
        splashColor: lightBackgroundColor,
        child: Padding(
          padding: areaListButtonPadding,
          child: Row(
            children: [
              Image.asset(
                smallImageUrl,
                scale: areaListImageScale,
              ),
              const HorizontalSpace(space: 12.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    area,
                    style: TextStyles.semiBold.copyWith(letterSpacing: 4.0),
                  ),
                  const VerticalSpace(space: 4.0),
                  // TODO: Update value
                  Text(
                    availableSpotLabel,
                    style: TextStyles.light,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
