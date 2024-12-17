abstract class RecitationEvent {}

class OnStartRecording extends RecitationEvent {}

class OnFinishRecording extends RecitationEvent {}

class OnSendRecording extends RecitationEvent {}

class OnPlayRecording extends RecitationEvent {}

class OnPausePlayback extends RecitationEvent {}

class OnResumePlayback extends RecitationEvent {}
