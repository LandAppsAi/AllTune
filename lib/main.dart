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
    return MaterialApp(
      title: 'AllTune',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const HomeScreen(),
    );
  }
}

