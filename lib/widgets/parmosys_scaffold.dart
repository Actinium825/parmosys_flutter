import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:parmosys_flutter/feature/parmosys_drawer/parmosys_drawer.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/extension.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class ParmosysScaffold extends StatelessWidget {
  const ParmosysScaffold({
    required this.header,
    required this.cardBody,
    required this.body,
    this.isBackButtonShown = false,
    this.cardRadius = categoryPageCardRadius,
    super.key,
  });

  final bool isBackButtonShown;
  final double cardRadius;
  final Widget cardBody;
  final Widget body;
  final List<String> header;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    final extraBold = TextStyles.extraBold;
    final borderRadius = BorderRadius.circular(searchTextRadius);

    return Scaffold(
      backgroundColor: isDarkMode ? darkBackgroundColor : lightBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: isBackButtonShown,
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
                FittedBox(
                  child: Padding(
                    padding: isBackButtonShown ? additionalHeaderPadding : EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          header.firstOrNull ?? '',
                          style: extraBold,
                        ),
                        Row(
                          children: [
                            Text(
                              header.second,
                              style: extraBold,
                            ),
                            const Icon(
                              Icons.location_on_rounded,
                              color: locationButtonColor,
                              size: locationIconSize,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const VerticalSpace(space: 20.0),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: borderRadius,
                  ),
                  height: searchTextHeight,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: hintTextLabel,
                      hintStyle: TextStyles.light,
                      border: OutlineInputBorder(borderRadius: borderRadius),
                      contentPadding: hintTextPadding,
                      suffixIcon: const Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body,
          Expanded(
            child: Card(
              color: isDarkMode ? bottomSheetDarkColor : Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(cardRadius))),
              margin: EdgeInsets.zero,
              child: cardBody,
            ),
          )
        ],
      ),
    );
  }
}
