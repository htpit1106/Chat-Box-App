import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/widgets/image/app_asets_image.dart';
import 'package:flutter/material.dart';

class AppSocialButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onPressed;
  final Color? colorBorder;

  const AppSocialButton({super.key, required this.iconPath, this.onPressed, this.colorBorder});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: AppAssetImage(path: iconPath, size: const Size(24, 24)),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: colorBorder?? AppColors.borderBlack, width: 1)
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
