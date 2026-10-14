import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:street_bite_test/core/preferences/app_preferences.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final AppPreferences _prefs;

  ThemeCubit(this._prefs) : super(ThemeMode.system);

  void loadTheme() {
    final saved = _prefs.getThemeMode();
    switch (saved) {
      case 'light':
        emit(ThemeMode.light);
      case 'dark':
        emit(ThemeMode.dark);
      default:
        emit(ThemeMode.system);
    }
  }

  Future<void> setTheme(ThemeMode mode) async {
    await _prefs.saveThemeMode(mode.name);
    emit(mode);
  }
}
