import 'package:chat/models/message_model.dart';
import 'package:flutter/material.dart';

import '../constans/colors.dart';

class AnotherChatBubble extends StatelessWidget {
  AnotherChatBubble({super.key, required this.message});
  Message message;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: kActiveColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          message.message,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            shadows: <Shadow>[
              Shadow(
                color: Colors.white,
                blurRadius: 90.0,
              ),
            ],
            fontSize: 23,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
