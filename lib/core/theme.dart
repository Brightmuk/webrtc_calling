import 'package:flutter/material.dart';

final themeColor = Color.fromRGBO(150, 18, 61, 1);
final themeColorDark = Color.fromRGBO(182, 23, 75, 1);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: themeColor,
    brightness: Brightness.light,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.white,
        minimumSize: Size(double.infinity, 50),
      side: const BorderSide(color: Colors.white, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.white,
      foregroundColor: themeColor,
    ),
  ),
);
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: themeColorDark,
    brightness: Brightness.dark,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    
    style: OutlinedButton.styleFrom(
      minimumSize: Size(double.infinity, 50),
      foregroundColor: Colors.white,
      side: const BorderSide(color: Colors.white, width: 1.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: Colors.white,
      foregroundColor: themeColor,
    ),
  ),
);
