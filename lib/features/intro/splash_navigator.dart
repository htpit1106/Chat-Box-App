import 'package:chatbox/core/base/base_navigator.dart';
import 'package:chatbox/navigation/app_router.dart';
import 'package:go_router/go_router.dart';

class SplashNavigator extends BaseNavigator {
  SplashNavigator({required super.context});
  void goOnboarding() {
    context.goNamed(AppRouter.onboardingRouteName);
  }
}
