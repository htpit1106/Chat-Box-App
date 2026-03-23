import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/core/utils/utils.dart';
import 'package:chatbox/data/repository/call_repository.dart';
import 'package:chatbox/data/repository/media_repository.dart';
import 'package:chatbox/features/main/calls/calls_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/configs/app_configs.dart';
import 'core/global/app_cubit/app_navigator.dart';
import 'core/network/agora_rtc_service.dart';
import 'core/theme/app_theme.dart';
import 'data/repository/auth_repository.dart';
import 'data/repository/conversation_repository.dart';
import 'data/repository/friend_repository.dart';
import 'data/repository/user_repository.dart';
import 'features/main/calls/calls_navigator.dart';
import 'generated/l10n.dart';
import 'navigation/app_router.dart';

class ChatBoxApp extends StatelessWidget {
  const ChatBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(create: (_) => AuthRepositoryImpl()),
        RepositoryProvider<UserRepository>(create: (_) => UserRepositoryImpl()),
        RepositoryProvider<FriendRepository>(
          create: (_) => FriendRepositoryImpl(),
        ),
        RepositoryProvider<ConversationRepository>(
          create: (_) => ConversationRepositoryImpl(),
        ),
        RepositoryProvider<MediaRepository>(
          create: (_) => MediaRepositoryImpl(),
        ),
        RepositoryProvider<CallRepository>(create: (_) => CallRepositoryImpl()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(
            create: (context) => AppCubit(
              navigator: AppNavigator(context: context),
              userRepos: context.read(),
              callRepos: context.read(),
            ),
          ),
          BlocProvider<CallsCubit>(
            create: (context) => CallsCubit(
              callRepos: context.read(),
              appCubit: context.read(),
              agora: AgoraService()..init(),
              navigator: CallsNavigator(context: context),
            ),
          ),
        ],
        child: BlocBuilder<AppCubit, AppState>(
          buildWhen: (previous, current) =>
              previous.currentLanguage != current.currentLanguage,
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                hideKeyboard(context);
              },
              child: MaterialApp.router(
                title: AppConfigs.appName,
                routerConfig: AppRouter.router,
                theme: AppThemes.lightTheme,
                themeMode: ThemeMode.light,
                supportedLocales: S.delegate.supportedLocales,
                locale: state.currentLanguage.local,
                localizationsDelegates: [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
