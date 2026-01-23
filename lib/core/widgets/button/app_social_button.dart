import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/widgets/image/app_asets_image.dart';
import 'package:flutter/material.dart';

class AppSocialButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback? onPressed;
  final Color? colorBorder;
  final Color? colorIcon;

  const AppSocialButton({
    super.key,
    required this.iconPath,
    this.onPressed,
    this.colorBorder,
    this.colorIcon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: AppAssetImage(path: iconPath, size: const Size(24, 24), colorIcon: colorIcon),
      style: IconButton.styleFrom(
        padding: 10.paddingAll,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: BorderSide(color: colorBorder ?? AppColors.borderBlack, width: 1),
        ),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
