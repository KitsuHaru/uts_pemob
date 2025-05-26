import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_themes.dart'; // Pastikan path ini benar
import 'theme/theme_provider.dart'; // Pastikan path ini benar
import 'screens/loading_screen.dart'; // Pastikan path ini benar

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Penting untuk SharedPreferences
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Menggunakan watch agar UI rebuild saat tema berubah
    final themeProvider = context.watch<ThemeProvider>();
    return MaterialApp(
      title: 'Posisi App',
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darkTheme,
      themeMode: themeProvider.themeMode,
      debugShowCheckedModeBanner: false,
      home: const LoadingScreen(), // Halaman awal adalah loading screen
    );
  }
}
