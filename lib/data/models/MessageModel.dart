
class MessageModel {
  final String? message;
  final String? videoUrl;
  final String? audioPath;

  final bool isSender;

  MessageModel({this.message, this.videoUrl, required this.isSender, this.audioPath});
}
