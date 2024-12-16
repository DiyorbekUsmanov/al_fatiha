abstract class RecitationEvent {}

class OnStartRecording extends RecitationEvent {}

class OnFinishRecording extends RecitationEvent {}

class OnPlayRecording extends RecitationEvent {}

class OnSendRecording extends RecitationEvent {
  final String? filePath;

  OnSendRecording({this.filePath});
}