import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/MessageModel.dart';

Future<void> saveMessage(MessageModel message) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> messages = prefs.getStringList('messages') ?? [];
  messages.add(jsonEncode(message.toJson()));
  await prefs.setStringList('messages', messages);
}

Future<List<MessageModel>> getMessages() async {
  final prefs = await SharedPreferences.getInstance();
  final List<String>? jsonMessages = prefs.getStringList('messages');
  if (jsonMessages != null) {
    return jsonMessages
        .map((jsonMsg) => MessageModel.fromJson(jsonDecode(jsonMsg)))
        .toList();
  }
  return [];
}