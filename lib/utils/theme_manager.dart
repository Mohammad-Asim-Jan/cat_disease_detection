import '../utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager {
  static ThemeData lightMode = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Constants.mainColor,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.yellow.shade50,
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headlineMedium: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
    ),
    scaffoldBackgroundColor: Colors.yellow.shade50,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Constants.mainColor,
    ),
    useMaterial3: true,
  );
  static ThemeData darkMode = ThemeData(
    appBarTheme: const AppBarTheme(
      backgroundColor: Constants.mainColor,
      // You can keep the same color or choose a darker variant
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.white, // Change to white for better visibility
        fontSize: 17,
        fontWeight: FontWeight.bold,
      ),
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey[850], // Dark background for the drawer
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white, // Change to white for dark mode
      ),
      headlineMedium: TextStyle(
        fontSize: 16,
        color: Colors.white, // Change to white for dark mode
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    // Dark background for the scaffold
    colorScheme: ColorScheme.fromSeed(
      seedColor: Constants.mainColor,
      brightness: Brightness.dark, // Set brightness to dark
    ),
    useMaterial3: true,
  );

  static Future<bool> isDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    return isDarkMode;
  }
}
