import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:chatbox/core/widgets/image/app_cache_image.dart';
import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String? title;
  final String? iconTrailing;
  final VoidCallback? onPressSearch;
  final VoidCallback? onPressTrailing;

  const CustomAppbar({
    super.key,
    this.title,
    this.iconTrailing,
    this.onPressSearch,
    this.onPressTrailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: onPressSearch,
          icon: AppAssetImage(path: AssetConstants.search, size: Size(44, 44)),
        ),
        Text(title ?? "Home", style: AppTextStyle.white.s20.w500),

        ClipRRect(
          borderRadius: 100.radius,
          child: IconButton(
            onPressed: () {},
            icon: AppCacheImage(
              path: iconTrailing ?? AssetConstants.addFriendContact,
              size: Size(44, 44),
            ),
          ),
        ),
      ],
    );
  }
}
