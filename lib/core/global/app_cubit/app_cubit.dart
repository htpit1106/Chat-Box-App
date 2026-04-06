import 'package:chatbox/core/configs/app_configs.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/data/models/enum/language_type.dart';
import 'package:chatbox/data/models/enum/load_status.dart';
import 'package:chatbox/data/repository/auth_repository.dart';
import 'package:chatbox/data/repository/call_repository.dart';
import 'package:chatbox/data/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_navigator.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  late AppNavigator _navigator;
  final UserRepository userRepos;
  final CallRepository callRepos;
  final AuthRepository authRepos;

  AppCubit({
    required this.userRepos,
    required this.callRepos,
    required this.authRepos,
  }) : super(AppState());

  // currentUser
  Future<void> getUserProfile() async {
    if (state.initDataStatus == LoadStatus.loading) return;
    emit(state.copyWith(initDataStatus: LoadStatus.loading));
    final result = await userRepos.getCurrentUserProfile();
    emit(
      state.copyWith(currentUser: result, initDataStatus: LoadStatus.success),
    );
  }

  Future<void> updateProfile(UserEntity? profile) async {
    emit(state.copyWith(currentUser: profile));
  }

  Future<void> logout() async {
    if (state.loadLogoutStatus.isLoading) return;
    emit(state.copyWith(loadLogoutStatus: LoadStatus.loading));
    final result = await authRepos.logout();
    result.fold((failure) {}, (success) {
      emit(state.copyWith(loadLogoutStatus: LoadStatus.success));
      _navigator.openLoginPage();
    });
  }

  void setupNavigator(BuildContext context) {
    _navigator = AppNavigator(context: context);
  }
}
