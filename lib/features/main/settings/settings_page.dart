import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/app_scaffold.dart';
import 'package:chatbox/core/widgets/divider/app_divider.dart';
import 'package:chatbox/features/main/settings/settings_cubit.dart';
import 'package:chatbox/features/main/settings/settings_navigator.dart';
import 'package:chatbox/features/main/settings/widget/setting_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingsCubit>(
      create: (context) => SettingsCubit(
        appCubit: context.read(),
        navigator: SettingsNavigator(context: context),
      ),
      child: SettingsPageChild(),
    );
  }
}

class SettingsPageChild extends StatefulWidget {
  const SettingsPageChild({super.key});

  @override
  State<SettingsPageChild> createState() => _SettingsPageChildState();
}

class _SettingsPageChildState extends State<SettingsPageChild> {
  late final SettingsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read();
  }

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
      // buildWhen: (previous, current) =>
      //     previous.currentUser != current.currentUser,
      builder: (context, state) {
        final user = state.currentUser;
        return InkWell(
          onTap: _cubit.navigateToProfile,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: SettingListItem(
              icon: user?.avatarUrl,
              title: user?.name,
              subtitle: user?.email != null
                  ? Text(
                      user!.email!,
                      style: AppTextStyle.gray.s12,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                    )
                  : null,
              iconSize: Size(60, 60),
              titleStyle: AppTextStyle.black.s20.w500,
              trailing: Icon(Icons.qr_code_scanner, color: AppColors.primary),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListSettingItem() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SettingListItem(
            title: "Account",
            subtitle: Text(
              "Privacy, security, change number",
              style: AppTextStyle.gray.s12,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            icon: AssetConstants.account,
          ),
          SettingListItem(
            title: "Chat",
            subtitle: Text(
              "Chat history, theme, wallpapers",
              style: AppTextStyle.gray.s12,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            icon: AssetConstants.chatSetting,
          ),
          SettingListItem(
            title: "Notifications",
            subtitle: Text(
              "Messages, group and others",
              style: AppTextStyle.gray.s12,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            icon: AssetConstants.notification,
          ),
          SettingListItem(
            title: "Help",
            subtitle: Text(
              "Help center, contact us, privacy policy",
              style: AppTextStyle.gray.s12,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
            icon: AssetConstants.helpSetting,
          ),
          SettingListItem(
            title: "Invite a friend",
            icon: AssetConstants.inviteFriend,
          ),
        ],
      ),
    );
  }
}
