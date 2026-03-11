import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/app_scaffold.dart';
import 'package:chatbox/core/widgets/divider/app_divider.dart';
import 'package:chatbox/features/main/settings/widget/setting_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(header: _buildHeader(), body: _buildBody());
  }

  Widget _buildHeader() {
    return Text("Setting", style: AppTextStyle.white.s20.w500);
  }

  Widget _buildBody() {
    return Column(
      children: [_buildProfileHeader(), AppDivider(), _buildListSettingItem()],
    );
  }

  Widget _buildProfileHeader() {
    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        final user = state.currentUser;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: SettingListItem(
            icon: user?.avatarUrl,
            title: user?.name,
            subtitle: user?.email,
            iconSize: Size(60, 60),
            titleStyle: AppTextStyle.black.s20.w500,
            trailing: Icon(Icons.qr_code_scanner, color: AppColors.primary),
          ),
        );
      },
    );
  }

  Widget _buildListSettingItem() {
    return Column(
      children: [
        SettingListItem(
          title: "Account",
          subtitle: "Privacy, security, change number",
          icon: AssetConstants.account,
        ),
        SettingListItem(
          title: "Chat",
          subtitle: "Chat history, theme, wallpapers",
          icon: AssetConstants.chatSetting,
        ),
        SettingListItem(
          title: "Notifications",
          subtitle: "Messages, group and others",
          icon: AssetConstants.notification,
        ),
        SettingListItem(
          title: "Help",
          subtitle: "Help center, contact us, privacy policy",
          icon: AssetConstants.helpSetting,
        ),
        SettingListItem(
          title: "Invite a friend",
          icon: AssetConstants.inviteFriend,
        ),
      ],
    );
  }
}
