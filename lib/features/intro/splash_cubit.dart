import 'package:chatbox/data/database/secure_storage_helper.dart';
import 'package:chatbox/features/intro/splash_navigator.dart';
import 'package:chatbox/features/intro/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashCubit extends Cubit<SplashState>{
  final SplashNavigator navigator;
  SplashCubit({required this.navigator}): super(SplashState());
  void checkOnboard() async{
    final isFirstRun = await SecureStorageHelper.isFirstRun;
    if (isFirstRun) {
      navigator.goOnboarding();
      return ;
    }
    _checkLogin();

  }
  void _checkLogin(){
    navigator.openLoginPage();
  }
}