import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for SystemNavigator.pop()

Widget customAppBar(BuildContext context, String title) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
    decoration: BoxDecoration(
      color: Colors.white, // Inner container background
      borderRadius: BorderRadius.circular(10), // 10 radius all sides
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            // Check if the current route can be popped
            if (Navigator.canPop(context)) {
              Navigator.pop(context); // Pop current screen
            } else {
              SystemNavigator.pop(); // Exit the app
            }
          },
          child: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        Text(
          title, // Use the argument here
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(),
      ],
    ),
  );
}
