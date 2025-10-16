import 'package:flutter/material.dart';

final themeColor = Color.fromRGBO(79, 14, 64, 1);
final themeColorDark = Color.fromRGBO(101, 19, 60, 1);


final lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(seedColor: themeColor,
  brightness: Brightness.light,
  )
);
final darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: themeColorDark,
    brightness: Brightness.dark,
    )
);