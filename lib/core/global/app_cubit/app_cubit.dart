import 'package:chatbox/core/configs/app_configs.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/data/models/enum/language_type.dart';
import 'package:chatbox/data/repository/call_repository.dart';
import 'package:chatbox/data/repository/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_navigator.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  final AppNavigator navigator;
  final UserRepository userRepos;
  final CallRepository callRepos;

  AppCubit({
    required this.userRepos,
    required this.navigator,
    required this.callRepos,
  }) : super(AppState());

  // currentUser
  Future<void> getUserProfile() async {
    final result = await userRepos.getCurrentUserProfile();
    emit(state.copyWith(currentUser: result));
  }

  Future<void> updateProfile(UserEntity? profile) async {
    emit(state.copyWith(currentUser: profile));
  }
}
