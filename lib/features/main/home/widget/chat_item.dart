import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'avatar_with_status.dart';

class ChatItem extends StatelessWidget {
  // id key
  final String? id;
  final String? avatar;
  final String? name;
  final String? lastMessage;
  final String? time;
  final int unreadCount;
  final bool? isOnline;
  final bool? onNotification;
  final VoidCallback? onPressDelete;
  final VoidCallback? onPressNotification;
  final VoidCallback? onTap;
  const ChatItem({
    super.key,
    this.id,
    this.avatar,
    this.name = "Alex LinderSon",
    this.lastMessage = "How are you today",
    this.time = "2 min agoo",
    this.unreadCount = 3,
    this.isOnline = true,
    this.onNotification = false,
    this.onPressDelete,
    this.onPressNotification,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Slidable(
        key: Key(id ?? ""),
        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.3,
          openThreshold: 0.1,
          children: [
            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Slidable.of(context)?.close();
                    onPressNotification?.call();
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                    child: Icon(
                      onNotification == true ? Icons.notifications_active_rounded : Icons.notifications_off,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                );
              },
            ),
            16.width,

            Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Slidable.of(context)?.close(); //
                    onPressDelete?.call();
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: AppAssetImage(path: AssetConstants.trash, fit: BoxFit.none),
                  ),
                );
              },
            ),
          ],
        ),
        child: ListTile(
          leading: AvatarWithStatus(avatar: avatar, isOnline: isOnline ?? false),
          title: Text(
            name ?? '',
            style: AppTextStyle.black.s18.w500,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            lastMessage ?? 'no message',
            style: AppTextStyle.gray.s12,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time ?? 'no time', style: AppTextStyle.gray.s12),
              if (unreadCount  > 0)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                  child: Text(unreadCount.toString(), style: AppTextStyle.white.s12),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
