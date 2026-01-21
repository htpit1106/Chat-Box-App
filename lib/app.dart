import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/configs/app_configs.dart';
import 'core/theme/app_theme.dart';
import 'generated/l10n.dart';
import 'navigation/app_router.dart';

class ChatBoxApp extends StatefulWidget {
  const ChatBoxApp({super.key});

  @override
  State<ChatBoxApp> createState() => _ChatBoxAppState();
}

class _ChatBoxAppState extends State<ChatBoxApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<AppCubit>(create: (context) => AppCubit())],
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (previous, current) => previous.currentLanguage != current.currentLanguage,
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: MaterialApp.router(
              title: AppConfigs.appName,
              routerConfig: AppRouter.router,
              theme: AppThemes().theme,
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
    );
  }
}
