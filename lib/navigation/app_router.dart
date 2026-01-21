import 'package:chatbox/features/intro/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter._();
  static final navigationKey = GlobalKey<NavigatorState>();
  static final GoRouter router = GoRouter(
    initialLocation: _splashPath,
    routes: _routes,
    navigatorKey: navigationKey,
    debugLogDiagnostics: false,
  );

  // Route Paths
  static const _splashPath = '/';
  static const _onboardingPath = '/onboarding';
  static const String _loginPath = '/login';
  static const String _registerPath = '/register';
  static const String _forgotPasswordPath = '/forgot-password';
  static const String _homePath = '/home';

  // Name
  static const String splashRouteName = 'splash';
  static const String onboardingRouteName = 'onboarding';
  static const String loginRouteName = 'login';
  static const String registerRouteName = 'register';
  static const String forgotPasswordRouteName = 'forgotPassword';
  static const String homeName = 'home';



  static final _routes = <RouteBase>[
    GoRoute(
      name: splashRouteName,
      path: _splashPath,
      builder: (context, state) => const SplashPage(),
    ),

    // GoRoute(name:  onboardingRouteName,
    //   path: _onboardingPath,
    //   builder: (context, state) => const OnboardingPage(),)
  ];

}