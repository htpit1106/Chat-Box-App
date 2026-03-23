import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/data/database/secure_storage_helper.dart';
import 'package:chatbox/data/repository/auth_repository.dart';
import 'package:chatbox/features/intro/splash_navigator.dart';
import 'package:chatbox/features/main/calls/calls_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<void> {
  final SplashNavigator navigator;
  final AuthRepository authRepository;
  final AppCubit appCubit;
  final CallsCubit callsCubit;

  SplashCubit({
    required this.navigator,
    required this.authRepository,
    required this.appCubit,
    required this.callsCubit,
  }) : super(null);

  void init() async {
    Future.delayed(Duration(seconds: 3), () {
      checkOnboard();
    });
    await appCubit.getUserProfile();
    final currentId = appCubit.state.currentUser?.uid;
    if (currentId == null) {
      return;
    }
    callsCubit.listenIncoming(currentId);
  }

  void checkOnboard() async {
    final isFirstRun = await SecureStorageHelper.isFirstRun;
    if (isFirstRun) {
      navigator.goOnboarding();
      return;
    }
    _checkLogin();
  }

  void _checkLogin() {
    final isLoggedIn = authRepository.isLoggedIn();
    if (isLoggedIn) {
      navigator.openHome();
      appCubit.getUserProfile();
      return;
    }
    navigator.openLoginPage();
  }
}
