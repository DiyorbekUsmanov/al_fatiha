// message_items.dart
import 'package:flutter/material.dart';
import '../../data/models/SenderMessageModel.dart';

Widget chatWidget(List<SenderMessageModel> messages) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return buildSenderItem(context, message, isSender: true);
        },
      ),
    ),
  );
}

Widget buildSenderItem(BuildContext context, SenderMessageModel message, {bool isSender = false}) {
  return ListTile(
    title: Text(message.text),
    subtitle: GestureDetector(
      onTap: () {
        // TODO: Implement audio playback here
      },
      child: const Icon(
        Icons.play_arrow,
        size: 30,
        color: Colors.green,
      ),
    ),
  );
}
