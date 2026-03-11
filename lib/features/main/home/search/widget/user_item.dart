import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:chatbox/features/main/home/widget/avatar_with_status.dart';
import 'package:flutter/material.dart';

class UserItem extends StatelessWidget {
  final String? name;
  final String? avatar;
  final String? email;
  final bool? isFriend;
  final VoidCallback? onTap;

  const UserItem({
    super.key,
    this.name,
    this.avatar,
    this.email,
    this.isFriend = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: AvatarWithStatus(avatar: avatar),
      title: Text(
        name ?? 'Hoang Thi Phuong',
        style: AppTextStyle.black.s18.w500,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        email ?? 'phuonggm204@gmail.com',
        style: AppTextStyle.gray.s12,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: isFriend == true
          ? null
          : IconButton(
              onPressed: onTap,
              icon: AppAssetImage(
                path: AssetConstants.addFriend,
                size: Size(18, 18),
              ),
            ),
    );
  }
}
