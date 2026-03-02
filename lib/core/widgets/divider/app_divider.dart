import 'package:chatbox/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppDivider extends StatelessWidget {
  final double? height;
  final Color? color;

  const AppDivider({super.key, this.height, this.color});

  @override
  Widget build(BuildContext context) {
    return Divider(height: height ?? 1, color: color ?? AppColors.divider);
  }
}
