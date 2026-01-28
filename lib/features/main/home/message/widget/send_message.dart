import 'package:flutter/material.dart';

class SendMessage extends StatelessWidget {
  final String message;
  final String time;

  const SendMessage({super.key, this.message = "You did your job well!",  String? time})
    : time = time ?? "12:00";

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(left: 60, right: 12, bottom: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF0BA37F),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child:  Text(message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
