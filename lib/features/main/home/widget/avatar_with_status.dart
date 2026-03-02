import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:flutter/material.dart';

class AvatarWithStatus extends StatelessWidget {
  final String? avatar;
  final bool isOnline;

  const AvatarWithStatus({super.key, this.avatar, this.isOnline = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 48,
          height: 48,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: avatar == null
                ? AppAssetImage(path: AssetConstants.onboardingBg)
                : Image.network(avatar!),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 4,
          child: AppAssetImage(
            path: AssetConstants.onlinePoint,
            size: Size(10, 10),
            colorIcon: isOnline ? Color(0xFF0FE16D) : Colors.grey,
          ),
        ),
      ],
    );
  }
}
