import 'package:chatbox/core/base/base_navigator.dart';
import 'package:chatbox/navigation/app_router.dart';
import 'package:go_router/go_router.dart';

class OnboardingNavigator extends BaseNavigator {
  OnboardingNavigator({required super.context});
  void pushToLogIn() {
    context.pushNamed(AppRouter.loginRouteName);
  }

  void pushToSignUp() {
    context.pushNamed(AppRouter.registerRouteName);
  }
}
