import 'package:chatbox/data/models/entity/call_entity.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/features/auth/login/log_in_page.dart';
import 'package:chatbox/features/auth/signup/sign_up_page.dart';
import 'package:chatbox/features/intro/splash_page.dart';
import 'package:chatbox/features/main/calls/calling/calling_screen.dart';
import 'package:chatbox/features/main/calls/calls_page.dart';
import 'package:chatbox/features/main/calls/incomming_call/incoming_call.dart';
import 'package:chatbox/features/main/contacts/contacts_page.dart';
import 'package:chatbox/features/main/contacts/friend_profile/friend_profile_page.dart';
import 'package:chatbox/features/main/home/home_page.dart';
import 'package:chatbox/features/main/home/message/message_page.dart';
import 'package:chatbox/features/main/main_page.dart';
import 'package:chatbox/features/main/settings/profile/profile_page.dart';
import 'package:chatbox/features/main/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/intro/onboarding/onboarding_page.dart';
import '../features/main/home/search/search_page.dart';

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
  static const String _homePath = '/home';
  static const String _mainPath = '/main';
  static const String _callPath = '/call';
  static const String _contactPath = '/contact';
  static const String _settingPath = '/setting';
  static const String _profilePath = '/profile';
  static const String _messagePath = '/message';
  static const String _searchPath = '/search';
  static const _callingPage = "/calling";
  static const _incomingCall = "/incoming_call";
  static const _friendProfile = "/friend_profile";

  // Name
  static const String splashRouteName = 'splash';
  static const String onboardingRouteName = 'onboarding';
  static const String loginRouteName = 'login';
  static const String registerRouteName = 'register';
  static const String forgotPasswordRouteName = 'forgotPassword';
  static const String mainName = 'main';

  static const String homeName = 'home';
  static const String messageName = 'message';
  static const String searchName = 'search';

  static const String callName = 'call';
  static const String contactName = 'contact';
  static const String settingName = 'setting';
  static const String profileName = 'profile';
  static const String callingRouteName = 'calling';
  static const String incomingCallRouteName = 'incoming_call';
  static const String friendProfileRouteName = 'friend_profile';

  // Routes

  static final _routes = <RouteBase>[
    GoRoute(
      name: splashRouteName,
      path: _splashPath,
      builder: (context, state) => const SplashPage(),
    ),

    GoRoute(
      name: onboardingRouteName,
      path: _onboardingPath,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: _registerPath,
      name: registerRouteName,
      builder: (context, state) => SignUpPage(),
    ),
    GoRoute(
      path: _loginPath,
      name: loginRouteName,
      builder: (context, state) => LogInPage(),
    ),
    GoRoute(
      name: homeName,
      path: _homePath,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      name: mainName,
      path: _mainPath,
      builder: (context, state) => const MainPage(),
    ),
    GoRoute(
      name: callName,
      path: _callPath,
      builder: (context, state) => const CallsPage(),
    ),
    GoRoute(
      name: contactName,
      path: _contactPath,
      builder: (context, state) => const ContactsPage(),
    ),
    GoRoute(
      name: settingName,
      path: _settingPath,
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      name: messageName,
      path: _messagePath,
      builder: (context, state) {
        final friend = state.extra as UserEntity;
        return MessagePage(friend: friend);
      },
    ),
    GoRoute(
      name: searchName,
      path: _searchPath,
      builder: (context, state) => const SearchPage(),
    ),
    GoRoute(
      name: profileName,
      path: _profilePath,
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      name: callingRouteName,
      path: _callingPage,
      builder: (context, state) {
        final extra = state.extra as CallEntity?;
        if (extra == null) {
          return const CallingScreen();
        }
        return CallingScreen(call: extra);
      },
    ),
    GoRoute(
      name: incomingCallRouteName,
      path: _incomingCall,
      builder: (context, state) {
        final extra = state.extra as CallEntity?;

        if (extra == null) {
          return const IncomingCallScreen();
        }
        return IncomingCallScreen(call: extra);
      },
    ),
    GoRoute(
      name: friendProfileRouteName,
      path: _friendProfile,
      builder: (context, state) {
        final extra = state.extra as UserEntity?;

        return FriendProfilePage(friendProfile: extra);
      },
    ),
  ];
}
