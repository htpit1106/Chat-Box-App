import 'dart:async';
import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:chatbox/features/intro/splash_cubit.dart';
import 'package:chatbox/features/intro/splash_navigator.dart';
import 'package:chatbox/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(
        navigator: SplashNavigator(context: context),
        authRepository: context.read<AuthRepository>(),
      ),
      child: const SplashPageChild(),
    );
  }
}

class SplashPageChild extends StatefulWidget {
  const SplashPageChild({super.key});

  @override
  State<SplashPageChild> createState() => _SplashPageChildState();
}

class _SplashPageChildState extends State<SplashPageChild> {
  late final SplashCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<SplashCubit>(context);
    Future.delayed(Duration(seconds: 3), () {
      if (!mounted) return;
      _cubit.checkOnboard();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AppAssetImage(path: AssetConstants.logoApp)),
    );
  }
}
