import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:chatbox/core/widgets/image/app_cache_image.dart';
import 'package:flutter/material.dart';

class ImageMessage extends StatelessWidget {
  final String time;
  final bool isSend;
  final String? avatar;
  final String filePath;

  const ImageMessage({
    super.key,
    String? time,
    this.isSend = false,
    this.avatar,
    this.filePath = AssetConstants.errorLoadImage,
  }) : time = time ?? "12:00";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isSend
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isSend)
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: avatar == null
                ? AppAssetImage(
                    path: AssetConstants.onboardingBg,
                    size: const Size(40, 40),
                  )
                : Image.network(
                    avatar!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
          ),

        if (!isSend) const SizedBox(width: 6),

        Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: isSend
                ? const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
          ),
          child: AppCacheImage(
            path: filePath,
            size: const Size(150, 150),
            shape: BoxShape.rectangle,
          ),
        ),
      ],
    );
  }
}
