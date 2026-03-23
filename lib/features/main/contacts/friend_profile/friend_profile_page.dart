import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/app_scaffold.dart';
import 'package:chatbox/core/widgets/image/app_cache_image.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/features/main/contacts/friend_profile/friend_profile_cubit.dart';
import 'package:chatbox/features/main/contacts/friend_profile/friend_profile_state.dart';
import 'package:chatbox/features/main/contacts/widget/profile_field_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FriendProfilePage extends StatelessWidget {
  final UserEntity? friendProfile;

  const FriendProfilePage({super.key, this.friendProfile});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FriendProfileCubit>(
      create: (context) {
        return FriendProfileCubit(friendProfile: friendProfile);
      },
      child: const FriendProfileChild(),
    );
  }
}

class FriendProfileChild extends StatefulWidget {
  const FriendProfileChild({super.key});

  @override
  State<FriendProfileChild> createState() => _FriendProfileChildState();
}

class _FriendProfileChildState extends State<FriendProfileChild> {
  late final FriendProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(header: _buildHeader(), body: _buildBody());
  }

  Widget _buildHeader() {
    return BlocBuilder<FriendProfileCubit, FriendProfileState>(
      buildWhen: (previous, current) =>
          previous.friendProfile != current.friendProfile,
      builder: (context, state) {
        final friendInfo = state.friendProfile;
        if (friendInfo == null) return Container();
        return Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                ),
              ],
            ),

            AppCacheImage(
              path: friendInfo.avatarUrl ?? "", // demo
              size: const Size(80, 80),
              shape: BoxShape.circle,
              fit: BoxFit.cover,
            ),

            12.height,
            Text(friendInfo.name ?? "", style: AppTextStyle.white.s20),
            4.height,
            Text(
              friendInfo.email ?? "",
              style: AppTextStyle.white.s14.copyWith(color: Colors.white70),
            ),

            8.height,

            // ⚙️ Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildAction(Icons.chat_bubble_outline),
                _buildAction(Icons.videocam_outlined),
                _buildAction(Icons.call_outlined),
                _buildAction(Icons.more_horiz),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildAction(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(0.1),
      ),
      child: Icon(icon, color: Colors.white),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<FriendProfileCubit, FriendProfileState>(
      buildWhen: (previous, current) =>
          previous.friendProfile != current.friendProfile,
      builder: (context, state) {
        final friendInfo = state.friendProfile;
        if (friendInfo == null) return Container();
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,

            children: [
              ProfileFieldItem(
                label: "Display name",
                value: friendInfo.name ?? "",
              ),
              ProfileFieldItem(label: "Email", value: friendInfo.email ?? ""),
              ProfileFieldItem(label: "Phone", value: "+1 1"),
            ],
          ),
        );
      },
    );
  }
}
