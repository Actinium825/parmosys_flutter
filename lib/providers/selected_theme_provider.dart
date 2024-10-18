import 'package:flutter/material.dart';
import 'package:parmosys_flutter/providers/shared_preferences_provider.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_theme_provider.g.dart';

@riverpod
class SelectedTheme extends _$SelectedTheme {
  @override
  ThemeMode build() {
    final prefs = ref.read(sharedPreferencesProvider);
    final themeModeIndex = prefs.getInt(themeModeKey) ?? ThemeMode.light.index;

    return ThemeMode.values.elementAt(themeModeIndex);
  }

  void changeThemeMode(bool isDarkMode) {
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;

    final prefs = ref.read(sharedPreferencesProvider);
    prefs.setInt(themeModeKey, state.index);
  }
}
