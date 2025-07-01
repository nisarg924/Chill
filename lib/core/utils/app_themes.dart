import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/core/utils/style.dart';
import '../constants/app_color.dart';

class AppThemes {
  static appThemeData(String fontFamily) => {
    AppTheme.lightTheme: ThemeData(
      brightness: Brightness.light,
      primaryColor: const Color(0xFF00BFA6), // Mint
      scaffoldBackgroundColor: const Color(0xFFF5F6FA),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00BFA6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.black87),
        titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: const Color(0xFF81D4FA), // Light sky blue
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 20,
        backgroundColor: ColorConst.onBottomNavBackgroundLight,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorConst.onPrimaryContainerLight,
        unselectedItemColor: ColorConst.onSecondaryColorLight,
        selectedLabelStyle: fontStyleMedium10,
        unselectedLabelStyle: fontStyleMedium10,
      ),
      fontFamily: fontFamily,
      dividerColor: ColorConst.dividerLightColor,
      textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: ColorConst.whiteColor)),
    ),

    AppTheme.darkTheme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: const Color(0xFF1DE9B6), // Bright mint
      scaffoldBackgroundColor: const Color(0xFF121212),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF1F1F1F),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF1F1F1F),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1DE9B6),
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: Colors.white70),
        titleLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
      ),
      colorScheme: ColorScheme.fromSwatch(brightness: Brightness.dark).copyWith(
        secondary: const Color(0xFF4DD0E1), // Aqua
      ),
      fontFamily: fontFamily,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 20,
        backgroundColor: ColorConst.onBottomNavBackgroundDark,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: ColorConst.primaryContainerLight,
        unselectedItemColor: ColorConst.onSecondaryColorLight,
        selectedLabelStyle: fontStyleMedium10,
        unselectedLabelStyle: fontStyleMedium10,
      ),
      dividerColor: ColorConst.dividerDarkColor,
    ),
  };
}

enum AppTheme { lightTheme, darkTheme }

ColorScheme lightThemeColors() {
  return ColorScheme(
    brightness: Brightness.light,
    primary: ColorConst.primaryColor,
    onPrimary: ColorConst.onPrimaryColorLight,
    secondary: ColorConst.secondaryColorLight,
    onSecondary: ColorConst.onSecondaryColorLight,
    primaryContainer: ColorConst.primaryContainerLight,
    onPrimaryContainer: ColorConst.onPrimaryContainerLight,
    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
    background: ColorConst.primaryColorLight,
    onBackground: ColorConst.primaryColorLight,
    surface: ColorConst.textGradientOrangeColor,
    onSurface: ColorConst.whiteColor,
    outline: ColorConst.dashGreyLight,
  );
}

ColorScheme darkThemeColors() {
  return const ColorScheme(
    brightness: Brightness.dark,
    primary: ColorConst.primaryColorDark,
    onPrimary: ColorConst.onPrimaryColorDark,
    primaryContainer: ColorConst.primaryContainerDark,
    onPrimaryContainer: ColorConst.onPrimaryContainerDark,
    secondary: ColorConst.secondaryColorDark,
    onSecondary: ColorConst.onSecondaryColorDark,
    error: Color(0xFFF32424),
    onError: Color(0xFFF32424),
    background: ColorConst.primaryColorDark,
    onBackground: ColorConst.primaryColorDark,
    surface: ColorConst.textGradientOrangeColor,
    onSurface: ColorConst.whiteColor,
    outline: ColorConst.dashGreyDark,
  );
}
