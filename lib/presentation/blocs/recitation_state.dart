class RecitationState {
  final String? recordingPath;
  final String status;

  RecitationState({
    this.recordingPath,
    required this.status,
  });

  factory RecitationState.initial() {
    return RecitationState(
      recordingPath: null,
      status: 'initial',
    );
  }

  RecitationState copyWith({
    String? recordingPath,
    String? status,
  }) {
    return RecitationState(
      recordingPath: recordingPath ?? this.recordingPath,
      status: status ?? this.status,
    );
  }
}
