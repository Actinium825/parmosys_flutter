import 'package:flutter/material.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/widgets/parmosys_scaffold.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class AreaPage extends StatelessWidget {
  const AreaPage({super.key});

  static const route = 'area';

  @override
  Widget build(BuildContext context) {
    return const ParmosysScaffold(
      header: areaPageHeaders,
      body: VerticalSpace(space: 40.0),
      // TODO: Update card body
      cardBody: SizedBox(width: double.infinity),
      isBackButtonShown: true,
      cardRadius: areaPageCardRadius,
    );
  }
}
