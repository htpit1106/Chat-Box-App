import 'package:flutter/material.dart';

class DateDivider extends StatelessWidget {
  final String date;
  const DateDivider({super.key, this.date = "Today"});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        margin: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(date, style: TextStyle(fontSize: 11)),
      ),
    );
  }
}
