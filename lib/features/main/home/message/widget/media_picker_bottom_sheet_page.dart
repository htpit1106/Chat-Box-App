import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class MediaPickerBottomSheet extends StatelessWidget {
  final AssetEntity media;
  final VoidCallback? onTap;
  final bool isSelected;
  const MediaPickerBottomSheet({
    super.key,
    required this.media,
    this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return _buildMediaGrid();
  }

  Widget _buildMediaGrid() {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Positioned.fill(
            child: AssetEntityImage(
              media,
              isOriginal: false,
              thumbnailSize: const ThumbnailSize(200, 200),
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 6,
            right: 6,
            child: AppAssetImage(
              path: isSelected
                  ? AssetConstants.circleCheck
                  : AssetConstants.circleOutline,
              size: const Size(22, 22),
            ),
          ),
        ],
      ),
    );
  }
}
