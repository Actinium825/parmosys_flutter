import 'package:flutter/material.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const spacer = Spacer();
    return Scaffold(
      backgroundColor: homeBackgroundColor,
      body: Padding(
        padding: homePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spacer,
            Image.asset(Assets.png.lancer.path),
            const VerticalSpace(space: 32.0),
            Text(
              homeTitle,
              style: TextStyles.extraBold.copyWith(fontSize: 40),
            ),
            const VerticalSpace(space: 16.0),
            Text(
              homeDescription,
              style: TextStyles.light.copyWith(fontSize: 16),
            ),
            const VerticalSpace(space: 80.0),
            Center(
              child: ElevatedButton(
                // TODO: Add function
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  elevation: startButtonElevation,
                  backgroundColor: startButtonColor,
                  padding: startButtonPadding,
                  visualDensity: VisualDensity.compact,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(startButtonRadius)),
                ),
                child: Text(
                  startButtonLabel,
                  style: TextStyles.bold.copyWith(fontSize: 20),
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
