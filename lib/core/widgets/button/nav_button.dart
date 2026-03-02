import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  final String iconPath;
  final String text;
  final VoidCallback? onTap;
  final bool isSelected;

  const NavButton({
    super.key,
    this.iconPath = AssetConstants.message,
    this.text = 'Message',
    this.onTap,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppAssetImage(
            path: iconPath,
            size: Size(24, 24),
            colorIcon: isSelected ? AppColors.primary : AppColors.tertiary,
          ),
          Text(
            text,
            style: isSelected
                ? AppTextStyle.primary.s16
                : AppTextStyle.gray.s16,
          ),
        ],
      ),
    );
  }
}
