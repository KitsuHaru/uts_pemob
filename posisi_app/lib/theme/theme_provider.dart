import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light; // Default ke terang
  static const String _themePrefKey =
      'themeModePosisiApp'; // Kunci unik untuk aplikasi ini

  ThemeMode get themeMode => _themeMode;

  // Getter tambahan untuk memudahkan pengecekan dark mode
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  ThemeProvider() {
    _loadThemeMode();
  }

  void _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeString = prefs.getString(_themePrefKey);
      if (themeString == 'dark') {
        _themeMode = ThemeMode.dark;
      } else {
        _themeMode = ThemeMode.light; // Default jika tidak ada atau 'light'
      }
    } catch (e) {
      // Jika ada error saat load SharedPreferences (misal di web tanpa setup khusus), default ke terang
      _themeMode = ThemeMode.light;
      print('Error loading theme from SharedPreferences: $e');
    }
    notifyListeners();
  }

  Future<void> switchTheme() async {
    _themeMode =
        _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          _themePrefKey, _themeMode == ThemeMode.dark ? 'dark' : 'light');
    } catch (e) {
      print('Error saving theme to SharedPreferences: $e');
    }
    notifyListeners();
  }

  // Method toggleTheme yang memanggil switchTheme untuk konsistensi nama
  void toggleTheme() {
    switchTheme();
  }
}
