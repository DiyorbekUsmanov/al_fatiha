import 'dart:io';
import 'package:al_fatiha/core/services/log_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'recitation_event.dart';
import 'recitation_state.dart';

class RecitationBloc extends Bloc<RecitationEvent, RecitationState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioRecorder _audioRecorder = AudioRecorder();
  String? _filePath;

  RecitationBloc() : super(RecitationState.initial()) {
    on<OnStartRecording>((event, emit) async {
      try {
        final directory = await getApplicationDocumentsDirectory();
        final fileName =
            'recording_${DateTime.now().millisecondsSinceEpoch}.m4a';
        _filePath = '${directory.path}/$fileName';

        const config = RecordConfig(
          encoder: AudioEncoder.aacLc,
          sampleRate: 44100,
          bitRate: 128000,
        );

        if (await _audioRecorder.hasPermission()) {
          await _audioRecorder.start(
            config,
            path: _filePath!,
          );

          emit(state.copyWith(
            status: 'recording',
            recordingPath: null,
          ));
        } else {
          emit(state.copyWith(
            status: 'error',
            message: 'Microphone permission denied',
          ));
        }
      } catch (e) {
        LogService.e('Failed to start recording: $e');
        emit(state.copyWith(
          status: 'error',
          message: 'Failed to start recording',
        ));
      }
    });

    on<OnFinishRecording>((event, emit) async {
      try {
        if (await _audioRecorder.isRecording()) {
          final filePath = await _audioRecorder.stop();
          if (filePath != null) {
            _filePath = filePath;
            emit(state.copyWith(
              status: 'finished',
              recordingPath: _filePath,
            ));
          } else {
            emit(state.copyWith(
              status: 'error',
              message: 'Failed to save recording',
            ));
          }
        }
      } catch (e) {
        LogService.e('Failed to stop recording: $e');
        emit(state.copyWith(
          status: 'error',
          message: 'Failed to stop recording',
        ));
      }
    });

    on<OnSendRecording>((event, emit) async {
      try {
        if (_filePath != null) {
          final directory = await getApplicationDocumentsDirectory();
          final fileName = 'sent_${DateTime.now().millisecondsSinceEpoch}.m4a';
          final newFilePath = '${directory.path}/$fileName';
          await File(_filePath!).copy(newFilePath);
          _filePath = newFilePath;

          emit(state.copyWith(
            status: 'sent',
            recordingPath: _filePath,
          ));
        } else {
          emit(state.copyWith(
            status: 'error',
            message: 'No recording available to send',
          ));
        }
      } catch (e) {
        LogService.e('Failed to send recording: $e');
        emit(state.copyWith(
          status: 'error',
          message: 'Failed to send recording',
        ));
      }
    });

    on<OnPlayRecording>((event, emit) async {
      try {
        if (_filePath != null) {
          await _audioPlayer.setFilePath(_filePath!);
          _audioPlayer.play();
          emit(state.copyWith(status: 'playing'));
        } else {
          emit(state.copyWith(
            status: 'error',
            message: 'No recording available to play',
          ));
        }
      } catch (e) {
        LogService.e('Failed to play recording: $e');
        emit(state.copyWith(
          status: 'error',
          message: 'Failed to play recording',
        ));
      }
    });

    on<OnPausePlayback>((event, emit) async {
      try {
        _audioPlayer.pause();
        emit(state.copyWith(status: 'paused'));
      } catch (e) {
        LogService.e('Failed to pause playback: $e');
        emit(state.copyWith(
          status: 'error',
          message: 'Failed to pause playback',
        ));
      }
    });

    on<OnResumePlayback>((event, emit) async {
      try {
        _audioPlayer.play();
        emit(state.copyWith(status: 'playing'));
      } catch (e) {
        LogService.e('Failed to resume playback: $e');
        emit(state.copyWith(
          status: 'error',
          message: 'Failed to resume playback',
        ));
      }
    });
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
