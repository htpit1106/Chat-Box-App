import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class ProfileFieldItem extends StatelessWidget {
  final String label;
  final String value;

  const ProfileFieldItem({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyle.gray.s12),

          4.height,
          Padding(
            padding: 4.paddingHorizontal,
            child: Text(value, style: AppTextStyle.black.s16),
          ),
        ],
      ),
    );
  }
}
