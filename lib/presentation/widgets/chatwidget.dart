import 'package:al_fatiha/presentation/widgets/message_items.dart';
import 'package:flutter/material.dart';
import '../../data/models/ReceivedMessageModel.dart';

Widget chatWidget() {
  final List<ReceivedMessageModel> messages = [
    ReceivedMessageModel(
        message: "Fotiha surasida yo‘l qo‘yilishi mumkin bo‘lgan xatolar",
        videoUrl: "https://youtu.be/PLHddf-1MHY"),
  ];

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