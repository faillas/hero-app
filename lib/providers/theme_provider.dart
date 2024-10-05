import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  String? theme;
  ThemeMode? mode;

  ThemeProvider(
    {this.theme = 'light', this.mode = ThemeMode.system}
  );

  void changeTheme(String newTheme) {
    theme = newTheme;
    switch (newTheme) {
      case 'light':
        mode = ThemeMode.light; 
        break;
      case 'dark':
        mode = ThemeMode.dark;
        break;
      default: mode = ThemeMode.system;
    }
    notifyListeners();
  }


}
