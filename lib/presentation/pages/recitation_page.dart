import 'package:flutter/material.dart';

import '../../data/models/SenderMessageModel.dart';
import '../widgets/chatwidget.dart';
class RecitationPage extends StatefulWidget {
  const RecitationPage({super.key});

  @override
  _RecitationPageState createState() => _RecitationPageState();
}

class _RecitationPageState extends State<RecitationPage> {
  // List to hold the messages
  List<SenderMessageModel> messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recitation Page"),
        backgroundColor: Colors.green,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Other widgets above chat, like title and instructions

            // The chat widget to display messages
            Expanded(
              flex: 5,
              child: chatWidget(messages), // Pass the messages here
            ),

            // "Yuborish" Button to send the audio message
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () async {
                  // Here, add the new message when the button is pressed
                  final senderMessage = SenderMessageModel(
                    text: "Fotiha surasini qiroat qilish",
                    audioPath: "audioFilePath", // Pass actual audio file path here
                  );

                  // Add the message to the list and refresh the UI
                  setState(() {
                    messages.add(senderMessage);
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF30BF77),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Yuborish",
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
