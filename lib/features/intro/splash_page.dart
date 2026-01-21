import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/widgets/image/app_asets_image.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: AppAssetImage(
        path: AssetConstants.logoApp,
      ),),
    );
  }
}