import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget customAppBar(BuildContext context, String title) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              SystemNavigator.pop();
            }
          },
          child: const Icon(Icons.arrow_back_ios, size: 20),
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(),
      ],
    ),
  );
}
