import 'package:parmosys_flutter/providers/shared_preferences_provider.dart';
import 'package:parmosys_flutter/utils/enums.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_view_provider.g.dart';

@riverpod
class SelectedView extends _$SelectedView {
  @override
  AreaView build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final viewModeIndex = prefs.getInt(viewModeKey) ?? AreaView.gridView.index;

    return AreaView.values.elementAt(viewModeIndex);
  }

  void changeViewMode() {
    final isGridView = state.isGridView;
    state = isGridView ? AreaView.listView : AreaView.gridView;

    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setInt(viewModeKey, state.index);
  }
}
