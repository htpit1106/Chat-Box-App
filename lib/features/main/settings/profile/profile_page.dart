import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/app_bar/app_bar_widget.dart';
import 'package:chatbox/core/widgets/button/app_text_button.dart';
import 'package:chatbox/core/widgets/image/app_cache_image.dart';
import 'package:chatbox/core/widgets/text_field/app_label_text_field.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/features/main/settings/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_navigator.dart';
import 'profile_state.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileCubit>(
      create: (context) => ProfileCubit(
        appCubit: context.read(),
        userRepos: context.read(),
        navigator: ProfileNavigator(context: context),
      ),
      child: const ProfilePageChild(),
    );
  }
}

class ProfilePageChild extends StatefulWidget {
  const ProfilePageChild({super.key});

  @override
  State<ProfilePageChild> createState() => _ProfilePageChildState();
}

class _ProfilePageChildState extends State<ProfilePageChild> {
  late final ProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read();
    _cubit.init();
  }

  @override
  void dispose() {
    super.dispose();
    _cubit.nameController.dispose();
    _cubit.emailController.dispose();
    _cubit.birthdayController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Text("Edit Profile", style: AppTextStyle.black.s18),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(children: [_buildAvatar(), 24.height, _buildForm()]),
    );
  }

  // 🔹 Avatar (click to change)
  Widget _buildAvatar() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      buildWhen: (previous, current) =>
          previous.selectedAvatar != current.selectedAvatar,
      builder: (context, state) {
        return GestureDetector(
          onTap: () => _cubit.uploadAvatar(),
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              AppCacheImage(
                shape: BoxShape.circle,
                path: state.isSelectedAvatar ? state.selectedAvatar ?? "" : "",
                size: const Size(80, 80),
              ),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildForm() {
    return BlocSelector<AppCubit, AppState, UserEntity?>(
      selector: (state) => state.currentUser,
      builder: (context, user) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AppLabelTextField(
                controller: _cubit.nameController,
                label: "Name",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AppLabelTextField(
                controller: _cubit.emailController,
                label: "Email",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: AppLabelTextField(
                controller: _cubit.birthdayController,
                label: "Birthday",
              ),
            ),
            AppTextButton(
              text: "Update",
              onPressed: () {
                _cubit.onPressUpdate();
              },
            ),
          ],
        );
      },
    );
  }
}
