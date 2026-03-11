import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:flutter/material.dart';

class SettingListItem extends StatelessWidget {
  final String? icon;
  final String? title;
  final TextStyle? titleStyle;
  final String? subtitle;
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
          leading: AppAssetImage(
            path: icon ?? AssetConstants.personAvtDefault,
            size: iconSize,
          ),
          title: Text(
            title ?? "",
            style: titleStyle ?? AppTextStyle.black.s16.w500,
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle!,
                  style: AppTextStyle.gray.s12,
                  softWrap: false,
                  overflow: TextOverflow.fade,
                )
              : null,
          trailing: trailing,
        ),
      ),
    );
  }
}
