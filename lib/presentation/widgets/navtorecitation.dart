// Navigation to Recitation Widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/recitation_page.dart';

Widget navToRecitation(BuildContext context) {
  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25),
        topRight: Radius.circular(25),
      ),
    ),
    child: Container(
      margin: const EdgeInsets.fromLTRB(4, 4, 4, 40),
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 3,
              child: Text(
                "Qiroatni tekshirish...",
                style: TextStyle(color: Colors.grey[700]),
              )),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  CupertinoPageRoute(
                      builder: (context) => const RecitationPage()),
                );
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
                      "Qiroat qilish",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 12,
                      color: Colors.white,
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
