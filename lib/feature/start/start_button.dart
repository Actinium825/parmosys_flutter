import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/providers/loading_state_provider.dart';
import 'package:parmosys_flutter/providers/parking_spaces_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';

class StartButton extends ConsumerWidget {
  const StartButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = ref.watch(loadingStateProvider);
    return Center(
      child: loadingState.maybeWhen(
        loading: CircularProgressIndicator.new,
        orElse: () => ElevatedButton(
          onPressed: ref.read(parkingSpacesProvider().notifier).getAllDocuments,
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
