import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(AllTuneApp());
}

class AllTuneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AllTune',
      debugShowCheckedModeBanner: false,
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
      themeMode: ThemeMode.system,
      home: HomeScreen(),
    );
  }
}

