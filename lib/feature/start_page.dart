import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parmosys_flutter/feature/category/category_page.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/providers/parking_spaces_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final parkingSpaces = ref.watch(parkingSpacesProvider);

    ref.listen(
      parkingSpacesProvider,
      (previous, next) {
        if (previous?.isLoading == true && !next.hasError) context.goNamed(CategoryPage.route);
      },
    );

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
              child: parkingSpaces.maybeWhen(
                loading: CircularProgressIndicator.new,
                orElse: () => ElevatedButton(
                  onPressed: ref.watch(parkingSpacesProvider.notifier).getAllDocuments,
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
            ),
            spacer,
          ],
        ),
      ),
    );
  }
}
