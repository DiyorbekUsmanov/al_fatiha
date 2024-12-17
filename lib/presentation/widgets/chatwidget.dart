import 'package:al_fatiha/data/models/SenderMessageModel.dart';
import 'package:al_fatiha/presentation/widgets/received_message_card.dart';
import 'package:al_fatiha/presentation/widgets/sent_message_card.dart';
import 'package:flutter/material.dart';
import '../../data/models/MessageModel.dart';

Widget chatWidget(List<MessageModel> senderMessages) {
  List<MessageModel> messages = [
    MessageModel(
      message: "Fotiha surasida yo‘l qo‘yilishi mumkin bo‘lgan xatolar",
      videoUrl: "https://youtu.be/PLHddf-1MHY",
      isSender: false,
    ),
  ];
  messages.addAll(senderMessages);
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
          return message.isSender
              ? SentMessageWidget(message: message)
              : buildReceivedItem(context, message);
        },
      ),
    ),
  );
}
