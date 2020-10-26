import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import '../config/theme.dart';
import 'package:flutter/material.dart';

class ThemeUtils {
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static void toggleTheme(BuildContext context) {
    ThemeSwitcher.of(context).changeTheme(
      theme: isDarkMode(context) ? lightTheme : darkTheme,
    );
  }

  static void setThemeMode(BuildContext context, bool isDarkMode) {
    ThemeSwitcher.of(context).changeTheme(
      theme: isDarkMode ? darkTheme : lightTheme,
    );
  }

  static void setDarkMode(BuildContext context) {
    ThemeSwitcher.of(context).changeTheme(theme: darkTheme);
  }

  static void setLightMode(BuildContext context) {
    ThemeSwitcher.of(context).changeTheme(theme: lightTheme);
  }
}
