import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_navigator.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState>{
  final OnboardingNavigator navigator;
  OnboardingCubit({required this.navigator}): super(OnboardingState());
  void onPressLogin(){
    navigator.pushToLogIn();
  }
  void onPressSignUp() {
    navigator.pushToSignUp();
  }



}