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
    debugLogDiagnostics: true,
  );

  // Route Paths
  static const _splashPath = '/';
  // static const _home = '/home';

  // Name
  static const String splashRouteName = 'splash';

  static final _routes = <RouteBase>[
    GoRoute(
      name: splashRouteName,
      path: _splashPath,
      builder: (context, state) => const SplashPage(),
    ),
  ];

}