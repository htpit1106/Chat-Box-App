import 'package:chatbox/data/database/secure_storage_helper.dart';
import 'package:chatbox/data/repository/auth_repository.dart';
import 'package:chatbox/features/intro/splash_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<void> {
  final SplashNavigator navigator;
  final AuthRepository authRepository;

  SplashCubit({required this.navigator, required this.authRepository})
    : super(null);

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
      return;
    }
    navigator.openLoginPage();
  }
}
