import 'package:al_fatiha/presentation/widgets/customAppBar.dart';
import 'package:flutter/material.dart';

import '../widgets/chatwidget.dart';
import '../widgets/navtorecitation.dart';

class SurahPage extends StatelessWidget {
  const SurahPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: chatWidget(),
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
