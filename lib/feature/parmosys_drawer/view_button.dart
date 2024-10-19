import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parmosys_flutter/providers/selected_view_provider.dart';
import 'package:parmosys_flutter/utils/const.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:parmosys_flutter/utils/styles.dart';

class ViewButton extends ConsumerWidget {
  const ViewButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      ref.watch(selectedViewProvider).isGridView ? gridViewValue : listViewValue,
      style: TextStyles.medium.copyWith(color: viewModeTextColor),
    );
  }
}
