import 'dart:math';

class NoteMatch {
  final String note;
  final double targetFreq;
  final double cents;

  NoteMatch({required this.note, required this.targetFreq, required this.cents});
}

Map<String, double> standardGuitarTuning = {
  'E2': 82.41,
  'A2': 110.00,
  'D3': 146.83,
  'G3': 196.00,
  'B3': 246.94,
  'E4': 329.63,
};

NoteMatch matchFrequency(double freq, Map<String, double> tuning) {
  String bestNote = tuning.keys.first;
  double bestFreq = tuning[bestNote]!;
  double minDiff = (freq - bestFreq).abs();

  tuning.forEach((note, f) {
    final diff = (freq - f).abs();
    if (diff < minDiff) {
      minDiff = diff;
      bestNote = note;
      bestFreq = f;
    }
  });

  final cents = 1200 * (log(freq / bestFreq) / ln2);
  return NoteMatch(note: bestNote, targetFreq: bestFreq, cents: cents);
}
