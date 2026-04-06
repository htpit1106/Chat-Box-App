import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/data/repository/auth_repository.dart';
import 'package:chatbox/features/auth/login/log_in_navigator.dart';
import 'package:chatbox/features/auth/login/log_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInCubit extends Cubit<LogInState> {
  final AuthRepository authRepository;
  final LogInNavigator navigator;
  final AppCubit appCubit;

  LogInCubit({
    required this.navigator,
    required this.authRepository,
    required this.appCubit,
  }) : super(const LogInState(enableLogin: false));

  void onPressLogIn({required String email, required String password}) async {
    try {
      await authRepository.logIn(email: email, password: password);
      navigator.openHome();
      await appCubit.getUserProfile();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void changeEnableLogin(bool enable) {
    emit(state.copyWith(enableLogin: enable));
  }
}
