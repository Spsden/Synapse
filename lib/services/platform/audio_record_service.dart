import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

class AudioRecordingService {
  static final AudioRecordingService _instance =
      AudioRecordingService._internal();

  factory AudioRecordingService() => _instance;

  AudioRecordingService._internal();

  final AudioRecorder _recorder = AudioRecorder();
  Timer? _durationTimer;
  // Duration _currentDuration = Duration.zero;

  final StreamController<Duration> _durationController =
      StreamController<Duration>.broadcast();

  Stream<Duration> get recordingDurationStream => _durationController.stream;

  bool get isRecording => _durationTimer?.isActive == true;

  Future<void> startRecording() async {
    try {
      if (!await _recorder.hasPermission()) {
        throw Exception('Audio recording permission not granted');
      }

      final directory = await getApplicationDocumentsDirectory();
      final fileName = 'recording_${DateTime.now().microsecondsSinceEpoch}.m4a';
      final filePath = '${directory.path}/$fileName';

      const config = RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      );

      await _recorder.start(config, path: filePath);

      // Start duration tracking
      // _startDurationTracking();
    } catch (e) {
      throw Exception(("Failed to start recording: $e"));
    }
  }


  Future<String?> stopRecording() async {
    try {
      // _stopDurationTracking();

      final filePath = await _recorder.stop();

      if (filePath != null && await File(filePath).exists()) {
        return filePath;
      }

      return null;
    } catch (e) {
      // _stopDurationTracking();
      throw Exception('Failed to stop recording: $e');
    }
  }

  Future<void> cancelRecording() async {
    try {
      // _stopDurationTracking();
      await _recorder.cancel();
    } catch (e) {
      throw Exception('Failed to cancel recording: $e');
    }
  }

  Future<void> deleteRecording(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      throw Exception('Failed to delete recording: $e');
    }
  }

  Future<bool> hasPermission() async {
    return await _recorder.hasPermission();
  }

  Future<bool> requestPermission() async {
    return await _recorder.hasPermission();
  }

  void dispose() {
    _durationTimer?.cancel();
    _durationController.close();
    _recorder.dispose();
  }



}
