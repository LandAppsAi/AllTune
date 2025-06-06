import 'dart:async';
import 'package:flutter_fft/flutter_fft.dart';
import 'package:permission_handler/permission_handler.dart';

class DetectedPitch {
  final double frequency;

  DetectedPitch(this.frequency);
}

class TunerEngine {
  final FlutterFft _fft = FlutterFft();
  final StreamController<DetectedPitch> _controller = StreamController.broadcast();

  Stream<DetectedPitch> get onPitch => _controller.stream;

  Future<void> start() async {
    await Permission.microphone.request();
    await _fft.startRecorder();
    _fft.onRecorderStateChanged.listen((data) {
      final freq = data[1];
      if (freq is double && freq > 0) {
        _controller.add(DetectedPitch(freq));
      }
    });
  }

  Future<void> stop() async {
    await _fft.stopRecorder();
    await _controller.close();
  }
}
