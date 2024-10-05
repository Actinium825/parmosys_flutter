import 'package:parmosys_flutter/utils/enums.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'selected_view_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedView extends _$SelectedView {
  @override
  AreaView build() => AreaView.gridView;

  void changeViewMode() async {
    final isGridView = state.isGridView;
    state = isGridView ? AreaView.listView : AreaView.gridView;

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(viewModeKey, state.index);
  }

  void loadSavedView() async {
    final prefs = await SharedPreferences.getInstance();
    final viewModeIndex = prefs.getInt(viewModeKey) ?? AreaView.gridView.index;

    state = AreaView.values.elementAt(viewModeIndex);
  }
}
