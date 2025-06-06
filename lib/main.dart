import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const AllTuneApp());
}

/// Root widget for AllTune.
/// Holds light/dark themes and routes to the HomeScreen.
class AllTuneApp extends StatelessWidget {
  const AllTuneApp({super.key});

  @override
  Widget build(BuildContext context) {
    final baseLight = ThemeData.light();
    final baseDark = ThemeData.dark();

    return MaterialApp(
      title: 'AllTune',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: baseLight.copyWith(
        colorScheme: baseLight.colorScheme.copyWith(
          primary: Colors.deepPurple,
          secondary: Colors.deepPurpleAccent,
        ),
        scaffoldBackgroundColor: Colors.white,
        textTheme: baseLight.textTheme.apply(fontSizeFactor: 1.2),
        iconTheme: const IconThemeData(size: 32, color: Colors.deepPurple),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
        ),
      ),
      darkTheme: baseDark.copyWith(
        colorScheme: baseDark.colorScheme.copyWith(
          primary: Colors.deepPurpleAccent,
          secondary: Colors.deepPurple,
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: baseDark.textTheme.apply(fontSizeFactor: 1.2),
        iconTheme: const IconThemeData(size: 32, color: Colors.white),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
