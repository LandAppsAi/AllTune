import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Basic settings screen with toggle options.
class SettingsScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  const SettingsScreen({Key? key, required this.onThemeChanged}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _showFrequency = true;
  bool _showNoteName = true;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _showFrequency = prefs.getBool('showFrequency') ?? true;
      _showNoteName = prefs.getBool('showNoteName') ?? true;
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _updateBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Show Frequency'),
            value: _showFrequency,
            onChanged: (val) {
              setState(() => _showFrequency = val);
              _updateBool('showFrequency', val);
            },
          ),
          SwitchListTile(
            title: const Text('Show Note Name'),
            value: _showNoteName,
            onChanged: (val) {
              setState(() => _showNoteName = val);
              _updateBool('showNoteName', val);
            },
          ),
          SwitchListTile(
            title: const Text('Dark Theme'),
            value: _isDarkMode,
            onChanged: (val) {
              setState(() => _isDarkMode = val);
              _updateBool('isDarkMode', val);
              widget.onThemeChanged(val);
            },
          ),
        ],
      ),
    );
  }
}

