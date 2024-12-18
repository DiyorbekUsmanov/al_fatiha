import 'package:flutter/material.dart';
import '../../data/models/MessageModel.dart';
import 'customYouTubePlayer.dart';

Widget buildReceivedItem(BuildContext context, MessageModel message) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start ,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (message.videoUrl != null && message.videoUrl!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: YouTubePlayerWidget(videoUrl: message.videoUrl!),
                  ),
                const SizedBox(height: 8),
                Text(
                  message.message!,
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
