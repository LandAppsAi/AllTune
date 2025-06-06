import 'package:flutter/material.dart';
import 'lib/tuner_engine.dart';
import 'lib/tuning.dart';
import 'lib/widgets/tuning_dial.dart';

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
      home: TunerScreen(),
    );
  }
}

class TunerScreen extends StatefulWidget {
  @override
  _TunerScreenState createState() => _TunerScreenState();
}

class _TunerScreenState extends State<TunerScreen> {
  final TunerEngine _engine = TunerEngine();
  double _frequency = 0.0;
  NoteMatch? _match;

  @override
  void initState() {
    super.initState();
    _start();
  }

  Future<void> _start() async {
    await _engine.start();
    _engine.onPitch.listen((pitch) {
      setState(() {
        _frequency = pitch.frequency;
        _match = matchFrequency(_frequency, standardGuitarTuning);
      });
    });
  }

  @override
  void dispose() {
    _engine.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final noteText = _match != null ? _match!.note : '--';
    final cents = _match?.cents ?? 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('🎵 AllTune'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TuningDial(cents: cents),
          const SizedBox(height: 20),
          Text(
            '${_frequency.toStringAsFixed(2)} Hz',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          Text(
            noteText,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ],
      ),
    );
  }
}
