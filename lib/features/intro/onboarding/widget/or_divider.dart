import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final Color? colorDivider;
  const OrDivider({super.key, this.colorDivider = AppColors.divider});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: colorDivider)),
        Text("   OR   ", style: AppTextStyle.gray.s14.w300),
        Expanded(child: Divider(color: colorDivider)),
      ],
    );
  }
}
