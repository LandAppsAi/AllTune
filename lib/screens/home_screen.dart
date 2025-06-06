import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/tuning_dial.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;
  const HomeScreen({super.key, required this.onThemeChanged});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _instruments = ['Guitar', 'Violin', 'Ukulele'];
  String _instrument = 'Guitar';
  String _tuning = 'Standard';
  double _cents = 0;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _instrument = prefs.getString('instrument') ?? _instruments.first;
      _tuning = prefs.getString('tuning') ?? 'Standard';
    });
  }

  Future<void> _savePrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('instrument', _instrument);
    await prefs.setString('tuning', _tuning);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎵 AllTune'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SettingsScreen(
                    onThemeChanged: widget.onThemeChanged,
                  ),
                ),
              );
            },
          )
        ],
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          final dial = TuningDial(cents: _cents);
          final slider = Slider(
            value: _cents,
            min: -50,
            max: 50,
            label: '${_cents.toStringAsFixed(0)}c',
            onChanged: (v) => setState(() => _cents = v),
          );

          final instrumentSelector = Column(
            children: [
              const Text('Select Instrument'),
              DropdownButton<String>(
                value: _instrument,
                items: _instruments
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                onChanged: (val) {
                  if (val == null) return;
                  setState(() => _instrument = val);
                  _savePrefs();
                },
              ),
              const SizedBox(height: 16),
              Text('Current Instrument: $_instrument'),
            ],
          );

          if (orientation == Orientation.portrait) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                instrumentSelector,
                const SizedBox(height: 32),
                dial,
                const SizedBox(height: 32),
                Text(
                  'Pitch Offset: ${_cents.toStringAsFixed(1)} cents',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                slider,
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Center(child: dial)),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      instrumentSelector,
                      const SizedBox(height: 32),
                      Text(
                        'Pitch Offset: ${_cents.toStringAsFixed(1)} cents',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      slider,
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
