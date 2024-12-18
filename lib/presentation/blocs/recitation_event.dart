import '../../data/models/MessageModel.dart';

abstract class RecitationEvent {}

class OnStartRecording extends RecitationEvent {}

class OnFinishRecording extends RecitationEvent {}

class OnSendRecording extends RecitationEvent {
  final MessageModel message;

  OnSendRecording(this.message);
}

class OnPlayRecording extends RecitationEvent {}

class OnPausePlayback extends RecitationEvent {}

class OnResumePlayback extends RecitationEvent {}
