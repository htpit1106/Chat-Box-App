import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AppLabelTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final bool readOnly;

  // onchange
  final ValueChanged<String>? onChanged;

  const AppLabelTextField({
    super.key,
    required this.label,
    this.hintText = "",
    this.controller,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.initialValue,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: validator,
      builder: (field) {
        final hasError = field.hasError;
        final errorText = field.errorText;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: hasError
                  ? Theme.of(
                      context,
                    ).textTheme.labelLarge?.copyWith(color: Colors.red)
                  : Theme.of(context).textTheme.labelLarge,
            ),
            TextFormField(
              controller: controller,
              obscureText: obscureText,
              readOnly: readOnly,
              decoration: InputDecoration(
                hintText: hintText,
                errorText: field.hasError ? '' : null,
              ),
              onChanged: (value) {
                field.didChange(value);
                onChanged?.call(value);
              },
            ),
            if (hasError)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(errorText!, style: AppTextStyle.red.s12.w500),
                ),
              ),
          ],
        );
      },
    );
  }
}
