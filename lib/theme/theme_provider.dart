import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  // Initialize the theme mode
  ThemeMode _themeMode = ThemeMode.light;

  // Getter for themeMode
  ThemeMode get themeMode => _themeMode;

  // Getter for lightTheme
  ThemeData get lightTheme => ThemeData.light();

  // Getter for darkTheme
  ThemeData get darkTheme => ThemeData.dark();

  // Method to toggle between light and dark themes
  void toggleTheme() {
    _themeMode = (_themeMode == ThemeMode.light) ? ThemeMode.dark : ThemeMode.light;
    notifyListeners(); // Notify listeners about the change
  }
}
