import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final double minWidth;
  final TextStyle? textStyle;
  final bool enable;

  const AppTextButton({
    super.key,
    this.onPressed,
    this.text = "",
    this.color = AppColors.buttonGreen,
    this.minWidth = double.infinity,
    this.textStyle,
    this.enable = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enable ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: Size(minWidth, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
    ),
      child: Text(text, style: textStyle ?? AppTextStyle.white.s16.w500)
    );
  }
}
