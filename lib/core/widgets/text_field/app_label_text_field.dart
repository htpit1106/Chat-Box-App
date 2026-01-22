import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AppLabelTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;

  const AppLabelTextField({
    super.key,
    this.label = "",
    this.hintText = "",
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge,),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
