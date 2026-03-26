import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/image/app_cache_image.dart';
import 'package:flutter/material.dart';

class SettingListItem extends StatelessWidget {
  final String? icon;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? subtitle;
  final Size? iconSize;
  final Widget? trailing;
  final VoidCallback? onTap;

  const SettingListItem({
    super.key,
    this.icon,
    this.title,
    this.subtitle,
    this.titleStyle,
    this.iconSize,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          contentPadding: EdgeInsets.zero,

          leading: AppCacheImage(
            path: icon ?? AssetConstants.personAvtDefault,
            size: iconSize,
            fit: BoxFit.cover,
          ),
          title: Text(
            title ?? "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: titleStyle ?? AppTextStyle.black.s16.w500,
          ),
          subtitle: subtitle,
          trailing: trailing,
        ),
      ),
    );
  }
}
