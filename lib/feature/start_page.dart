import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:parmosys_flutter/feature/category/category_page.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  void _onPressStart(BuildContext context) => context.goNamed(CategoryPage.route);

  @override
  Widget build(BuildContext context) {
    const spacer = Spacer();
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: Padding(
        padding: startPagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacer,
            Image.asset(Assets.png.lancer.path),
            const VerticalSpace(space: 32.0),
            FittedBox(
              child: Text(
                homeTitle,
                style: TextStyles.extraBold,
              ),
            ),
            const VerticalSpace(space: 16.0),
            FittedBox(
              child: Text(
                homeDescription,
                style: TextStyles.light.copyWith(fontSize: 16),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () => _onPressStart(context),
                style: ElevatedButton.styleFrom(
                  elevation: startButtonElevation,
                  backgroundColor: startButtonColor,
                  padding: startButtonPadding,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(startButtonRadius)),
                ),
                child: Text(
                  startButtonLabel,
                  style: TextStyles.bold,
                ),
              ),
            ),
            spacer,
          ],
        ),
      ),
    );
  }
}
