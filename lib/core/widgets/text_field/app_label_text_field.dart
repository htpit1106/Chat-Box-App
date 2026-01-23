import 'dart:ffi';

import 'package:flutter/material.dart';

class AppLabelTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  // validator
  final String? Function(String?)? validator;


  const AppLabelTextField({
    super.key,
    this.label = "",
    this.hintText = "",
    this.controller,
    this.obscureText = false,
    this.validator,
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
          validator: validator,
        ),
      ],
    );
  }
}
