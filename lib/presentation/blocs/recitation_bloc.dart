// recitation_bloc.dart
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'recitation_event.dart';
import 'recitation_state.dart';

class RecitationBloc extends Bloc<RecitationEvent, RecitationState> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final AudioRecorder _audioRecorder = AudioRecorder();
  String? _filePath;

  RecitationBloc() : super(RecitationState.initial()) {
    on<OnStartRecording>((event, emit) async {
      // Start recording logic (already implemented)
    });

    on<OnFinishRecording>((event, emit) async {
      // Finish recording and save the file (already implemented)
    });

    on<OnSendRecording>((event, emit) async {
      // Check if there's a file path and save the recording
      if (_filePath != null) {
        final directory = await getApplicationDocumentsDirectory();
        final fileName = 'sent_${DateTime.now().millisecondsSinceEpoch}.m4a';
        final filePath = '${directory.path}/$fileName';

        // Copy the file to the new location
        await File(_filePath!).copy(filePath);

        emit(state.copyWith(
          recordingPath: filePath,  // Save the file path in the state
          status: 'finished', // Update the status to finished
        ));

        // Optionally, perform additional logic to "send" the file (upload, etc.)
      }
    });

    on<OnPlayRecording>((event, emit) {
      // Handle playback logic (already implemented)
    });
  }

  // Disposing resources when the bloc is closed
  @override
  Future<void> close() {
    _audioPlayer.dispose();
    _audioRecorder.dispose();
    return super.close();
  }
}
