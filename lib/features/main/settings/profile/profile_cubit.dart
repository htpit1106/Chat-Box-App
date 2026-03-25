import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/core/network/supabase_service.dart';
import 'package:chatbox/core/utils/utils.dart';
import 'package:chatbox/data/repository/user_repository.dart';
import 'package:chatbox/features/main/settings/profile/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'profile_navigator.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final SupabaseService supabaseService = SupabaseService();
  final AppCubit appCubit;
  final UserRepository userRepos;
  final ProfileNavigator navigator;

  ProfileCubit({
    required this.appCubit,
    required this.userRepos,
    required this.navigator,
  }) : super(ProfileState());

  void init() {
    getUserInfo();
    nameController.text = state.userInfo?.name ?? "";
    emailController.text = state.userInfo?.email ?? "";
    birthdayController.text = state.userInfo?.birthday ?? "";
    emit(state.copyWith(selectedAvatar: state.userInfo?.avatarUrl));
  }

  void getUserInfo() {
    final userInfo = appCubit.state.currentUser;
    emit(state.copyWith(userInfo: userInfo));
  }

  Future<void> uploadAvatar() async {
    try {
      final file = await pickImage();
      if (file == null) return;
      final publicUrl = await supabaseService.uploadImageToSupabase(
        folder: "avatars",
        file: file,
      );
      emit(state.copyWith(isSelectedAvatar: true, selectedAvatar: publicUrl));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  bool isEdited() {
    return nameController.text != state.userInfo?.name ||
        emailController.text != state.userInfo?.email ||
        birthdayController.text != state.userInfo?.birthday ||
        state.selectedAvatar != state.userInfo?.avatarUrl;
  }

  void onPressUpdate() async {
    if (!isEdited()) return;
    final userInfo = state.userInfo?.copyWith(
      name: nameController.text,
      email: emailController.text,
      birthday: birthdayController.text,
      avatarUrl: state.selectedAvatar,
    );

    await userRepos.updateProfile(userInfo);
    await appCubit.updateProfile(userInfo);

    navigator.pop();
  }
}
