import 'package:flutter/material.dart';
import '../widgets/tuning_dial.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _cents = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🎵 AllTune'),
        centerTitle: true,
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

          if (orientation == Orientation.portrait) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
