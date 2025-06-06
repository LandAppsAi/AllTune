import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🎵 AllTune'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'Welcome to AllTune!\nStart tuning your instrument.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
