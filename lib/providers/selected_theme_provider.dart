import 'package:flutter/material.dart';
import 'package:parmosys_flutter/utils/strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'selected_theme_provider.g.dart';

@riverpod
class SelectedTheme extends _$SelectedTheme {
  @override
  ThemeMode build() => ThemeMode.light;

  void changeThemeMode(bool isDarkMode) async {
    state = isDarkMode ? ThemeMode.dark : ThemeMode.light;

    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(themeModeKey, state.index);
  }

  void loadSavedTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeIndex = prefs.getInt(themeModeKey) ?? ThemeMode.light.index;

    state = ThemeMode.values.elementAt(themeModeIndex);
  }
}
