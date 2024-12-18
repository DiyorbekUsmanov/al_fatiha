
class RecitationState {
  final String? recordingPath;
  final String status;
  final String? message;

  RecitationState({
    this.message,
    this.recordingPath,
    required this.status,
  });

  factory RecitationState.initial() {
    return RecitationState(
      recordingPath: null,
      status: 'initial',
      message: "Nothing"
    );
  }

  RecitationState copyWith({
    String? message,
    String? recordingPath,
    String? status,
  }) {
    return RecitationState(
      message: message ?? this.message,
      recordingPath: recordingPath ?? this.recordingPath,
      status: status ?? this.status,
    );
  }
}
