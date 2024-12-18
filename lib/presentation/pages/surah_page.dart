import 'package:al_fatiha/presentation/widgets/customAppBar.dart';
import 'package:flutter/material.dart';

import '../../core/services/save_service.dart';
import '../../data/models/MessageModel.dart';
import '../../data/models/SenderMessageModel.dart';
import '../widgets/chatwidget.dart';
import '../widgets/navtorecitation.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({super.key,});


  @override
  State<SurahPage> createState() => _SurahPageState();
}

class _SurahPageState extends State<SurahPage> {
  late List<MessageModel> senderMessages;

  @override
  void initState() {
    fetchSenderMessages();
    super.initState();
  }

  Future<void> fetchSenderMessages() async {
    final messages = await getSenderMessages();
    setState(() {
      senderMessages = messages;
    });
  }

  Future<List<MessageModel>> getSenderMessages() async {
    final messages = await getMessages(); // Replace with your actual method
    return messages;
  }

  @override
  Widget build(BuildContext context) {
    final List<MessageModel> senderMessageModels = [];
    senderMessageModels.addAll(senderMessages);

    return Scaffold(
      extendBodyBehindAppBar: true, // Extends the body behind the app bar
      backgroundColor: Colors.grey[200], // Extends background to the edges
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top, // Top padding for status bar
          ),
          Expanded(
            flex: 1,
            child: customAppBar(context, "Fotiha Surasi"),
          ),
          Expanded(
            flex: 5,
            child: chatWidget(senderMessageModels),
          ),
          Expanded(
            flex: 1,
            child: navToRecitation(context),
          ),
        ],
      ),
    );
  }
}
