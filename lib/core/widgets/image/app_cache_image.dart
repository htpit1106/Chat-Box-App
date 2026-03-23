import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_assets_image.dart';

class AppCacheImage extends StatelessWidget {
  final String path;
  final Size? size;
  final BoxFit? fit;
  final Widget? placeholderImage;
  final BoxShape shape;

  const AppCacheImage({
    super.key,
    required this.path,
    this.size,
    this.fit = BoxFit.cover,
    this.placeholderImage,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    bool isNetworkUrl =
        path.startsWith('http://') || path.startsWith('https://');
    bool isFilePath = path.isNotEmpty && !isNetworkUrl;
    return Container(
      width: size?.width,
      height: size?.height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(shape: shape),
      child: _buildContent(isNetworkUrl: isNetworkUrl, isFilePath: isFilePath),
    );
  }

  Widget _buildContent({required bool isNetworkUrl, required bool isFilePath}) {
    if (isNetworkUrl) {
      return _buildNetworkImage();
    }
    if (isFilePath) {
      return _buildLocalImage();
    }
    return _buildPlaceHolderImage();
  }

  Widget _buildNetworkImage() {
    return CachedNetworkImage(
      imageUrl: path,
      fit: fit,

      progressIndicatorBuilder: (context, ure, downloadProgress) {
        return Container(
          width: (size?.width ?? 25) * 0.5,
          height: (size?.height ?? 25) * 0.5,
          constraints: const BoxConstraints(maxHeight: 25, maxWidth: 25),
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 2,
              value: downloadProgress.progress,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.primary,
              ),
            ),
          ),
        );
      },
      errorWidget: (context, url, error) {
        return Image.network(
          url,
          fit: fit,
          errorBuilder: (context, error, stackTrace) =>
              _buildPlaceHolderImage(),
        );
      },
    );
  }

  Widget _buildLocalImage() {
    final file = File(path);
    return Image.file(
      file,
      fit: fit,
      errorBuilder: (context, error, stackTrace) => _buildPlaceHolderImage(),
    );
  }

  Widget _buildPlaceHolderImage() {
    return placeholderImage ??
        AppAssetImage(
          path: AssetConstants.personAvtDefault,
          size: size ?? const Size(50, 50),
        );
  }
}
