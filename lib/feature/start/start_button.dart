import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/providers/loading_state_provider.dart';
import 'package:parmosys_flutter/providers/parking_spaces_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/env.dart';
import 'package:parmosys_flutter/utils/router.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';

class StartButton extends ConsumerWidget {
  const StartButton({super.key});

  void _onPressStart(BuildContext context, WidgetRef ref) => switch (Env.database) {
        appwrite => ref.read(parkingSpacesProvider().notifier).getAllDocuments(),
        firebase => CategoryRoute().go(context),
        _ => throw UnimplementedError('No database selected'),
      };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = ref.watch(loadingStateProvider);
    return Center(
      child: loadingState.maybeWhen(
        loading: CircularProgressIndicator.new,
        orElse: () => ElevatedButton(
          onPressed: () => _onPressStart(context, ref),
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
    );
  }
}
