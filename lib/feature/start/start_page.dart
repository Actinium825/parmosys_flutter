import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parmosys_flutter/feature/category/category_page.dart';
import 'package:parmosys_flutter/feature/start/start_button.dart';
import 'package:parmosys_flutter/gen/assets.gen.dart';
import 'package:parmosys_flutter/providers/loading_state_provider.dart';
import 'package:parmosys_flutter/providers/parking_spaces_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';
import 'package:parmosys_flutter/widgets/spacings.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  void _loadingStateListener(BuildContext context, AsyncValue<dynamic>? previous, AsyncValue<dynamic> next) {
    final hasError = next.hasError;

    if (hasError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(next.error.toString())));
    } else if (previous?.isLoading == true && !hasError) {
      context.pushNamed(CategoryPage.route);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const spacer = Spacer();

    ref.listen(loadingStateProvider, (previous, next) => _loadingStateListener(context, previous, next));

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
            spacer,
            const StartButton(),
            spacer,
          ],
        ),
      ),
    );
  }
}
