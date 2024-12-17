import 'package:al_fatiha/presentation/widgets/customAppBar.dart';
import 'package:flutter/material.dart';

import '../../data/models/MessageModel.dart';
import '../../data/models/SenderMessageModel.dart';
import '../widgets/chatwidget.dart';
import '../widgets/navtorecitation.dart';

class SurahPage extends StatelessWidget {
  final MessageModel? senderMessage;
  const SurahPage({super.key, this.senderMessage});

  @override
  Widget build(BuildContext context) {
    final List<MessageModel> senderMessageModels = [];
    if (senderMessage != null) {
      senderMessageModels.add(senderMessage!);
    }

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
