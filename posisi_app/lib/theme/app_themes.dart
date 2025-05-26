import 'package:flutter/material.dart';

class AppThemes {
  // Warna dasar untuk tema terang
  static const Color lightPrimaryHeaderColor = Color(0xFF2979FF);
  static const Color lightScaffoldBackgroundColor = Color(0xFFEEF2F5);
  static const Color lightCardColor = Colors.white;
  static const Color lightTextColor = Color(0xFF333333);
  static const Color lightLinkColor = Color(0xFF007BFF);
  static const Color lightButtonTextColor = Colors.white;

  // Warna dasar untuk tema gelap
  static const Color darkPrimaryHeaderColor = Color(0xFF1E1E1E);
  static const Color darkScaffoldBackgroundColor = Color(0xFF121212);
  static const Color darkCardColor = Color(0xFF1E1E1E);
  static const Color darkTextColor = Color(0xFFE0E0E0);
  static const Color darkLinkColor = Color(0xFFBB86FC);
  static const Color darkButtonTextColor = Colors.white;
  static const Color darkButtonBgStart = Color(0xFF3700B3);
  static const Color darkButtonBgEnd = Color(0xFF6200EE);

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: lightPrimaryHeaderColor,
    scaffoldBackgroundColor: lightScaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: lightPrimaryHeaderColor,
      foregroundColor: Colors.white,
      elevation: 4.0,
      titleTextStyle: TextStyle(
        fontFamily: 'BebasNeue',
        fontSize: 28,
        color: Colors.white,
        letterSpacing: 1,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          color: lightTextColor,
          fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          color: lightLinkColor,
          fontWeight: FontWeight.w500),
      bodyLarge:
          TextStyle(fontFamily: 'Roboto', fontSize: 16, color: lightTextColor),
      bodyMedium:
          TextStyle(fontFamily: 'Roboto', fontSize: 14, color: lightTextColor),
      labelLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: lightButtonTextColor,
          fontWeight: FontWeight.w500),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: lightButtonTextColor,
        backgroundColor: lightLinkColor,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(
            fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
      ),
    ),
    cardTheme: const CardThemeData(
      color: lightCardColor,
      elevation: 2,
      shadowColor: Color(0x14000000), // Set transparansi langsung
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: lightPrimaryHeaderColor,
      brightness: Brightness.light,
      primary: lightLinkColor,
      secondary: const Color(0xFF0056B3),
      background: lightScaffoldBackgroundColor,
      onBackground: lightTextColor,
      surface: lightCardColor,
      onSurface: lightTextColor,
    ),
    iconTheme: IconThemeData(color: lightTextColor.withOpacity(0.7)),
    dividerColor: Colors.grey[300],
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: const TextStyle(color: Colors.white, fontSize: 12),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkPrimaryHeaderColor,
    scaffoldBackgroundColor: darkScaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: darkPrimaryHeaderColor,
      foregroundColor: darkLinkColor,
      elevation: 4.0,
      titleTextStyle: TextStyle(
        fontFamily: 'BebasNeue',
        fontSize: 28,
        color: darkLinkColor,
        letterSpacing: 1,
      ),
      iconTheme: IconThemeData(color: darkLinkColor),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20,
          color: darkTextColor,
          fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          color: darkLinkColor,
          fontWeight: FontWeight.w500),
      bodyLarge:
          TextStyle(fontFamily: 'Roboto', fontSize: 16, color: darkTextColor),
      bodyMedium:
          TextStyle(fontFamily: 'Roboto', fontSize: 14, color: darkTextColor),
      labelLarge: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: darkButtonTextColor,
          fontWeight: FontWeight.w500),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: darkButtonTextColor,
        backgroundColor: darkLinkColor,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: const TextStyle(
            fontFamily: 'Roboto', fontSize: 16, fontWeight: FontWeight.w500),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2,
      ),
    ),
    cardTheme: const CardThemeData(
      color: darkCardColor,
      elevation: 2,
      shadowColor: Color(0x80000000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 0),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: darkLinkColor,
      brightness: Brightness.dark,
      primary: darkLinkColor,
      secondary: darkButtonBgStart,
      background: darkScaffoldBackgroundColor,
      onBackground: darkTextColor,
      surface: darkCardColor,
      onSurface: darkTextColor,
    ),
    iconTheme: IconThemeData(color: darkTextColor.withOpacity(0.7)),
    dividerColor: Colors.grey[700],
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(4),
      ),
      textStyle: const TextStyle(color: Colors.black, fontSize: 12),
    ),
  );
}
