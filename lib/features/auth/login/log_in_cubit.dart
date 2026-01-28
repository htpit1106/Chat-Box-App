import 'package:chatbox/features/auth/login/log_in_navigator.dart';
import 'package:chatbox/features/auth/login/log_in_state.dart';
import 'package:chatbox/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInCubit extends Cubit<LogInState> {
  final AuthRepository authRepository;
  final LogInNavigator navigator;

  LogInCubit({required this.navigator, required this.authRepository})
    : super(const LogInState(enableLogin: false));

  void onPressLogIn({required String email, required String password}) {
    try{
      authRepository.logIn(email: email, password: password);
      navigator.openHome();
    }catch(e){
      debugPrint(e.toString());
    }
  }

  void changeEnableLogin(bool enable) {
    emit(state.copyWith(enableLogin: enable));
  }
}
