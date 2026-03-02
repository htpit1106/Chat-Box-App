import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:flutter/material.dart';

class StatusItem extends StatelessWidget {
  final String? iconPath;
  final String? name;
  final double value;
  final VoidCallback? onTap;
  const StatusItem({
    super.key,
    this.iconPath,
    this.name = "My status",
    this.value = 1,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 48,
                  width: 48,
                  child: CircularProgressIndicator(
                    value: value,
                    color: AppColors.textWhite,
                    strokeWidth: 1,
                    strokeAlign: 3,
                  ),
                ),

                SizedBox(
                  height: 48,
                  width: 48,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: iconPath == null
                        ? AppAssetImage(path: AssetConstants.onboardingBg)
                        : Image.network(iconPath!),
                  ),
                ),
              ],
            ),
            Text(name ?? "", style: AppTextStyle.white.s14),
          ],
        ),
      ),
    );
  }
}
