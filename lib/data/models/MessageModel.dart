
class MessageModel {
  final String? message;
  final String? videoUrl;
  final String? audioPath;
  final bool isSender;
  final String? time;

  MessageModel({this.message, this.videoUrl, required this.isSender, this.audioPath, this.time});

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'videoUrl': videoUrl,
      'audioPath': audioPath,
      'isSender': isSender,
      'time': time,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      message: json['message'],
      videoUrl: json['videoUrl'],
      audioPath: json['audioPath'],
      isSender: json['isSender'],
      time: json['time'],
    );
  }
}
