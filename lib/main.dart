import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDarkMode') ?? false;
  runApp(AllTuneApp(isDarkMode: isDark));
}

/// Root widget for AllTune.
/// Holds light/dark themes and routes to the HomeScreen.
class AllTuneApp extends StatefulWidget {
  final bool isDarkMode;
  const AllTuneApp({super.key, required this.isDarkMode});

  @override
  State<AllTuneApp> createState() => _AllTuneAppState();
}

class _AllTuneAppState extends State<AllTuneApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.isDarkMode ? ThemeMode.dark : ThemeMode.light;
  }

  void _updateTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseLight = ThemeData.light();
    final baseDark = ThemeData.dark();

    return MaterialApp(
      title: 'AllTune',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
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
      home: HomeScreen(onThemeChanged: _updateTheme),
    );
  }
}
