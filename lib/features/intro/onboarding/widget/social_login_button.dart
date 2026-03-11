import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/widgets/button/app_social_button.dart';
import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  final Color? colorIconApple;
  const SocialLoginButton({super.key, this.colorIconApple});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 10,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppSocialButton(
          iconPath: AssetConstants.google,
          onPressed: () {},
          colorBorder: AppColors.borderSilverGray,
        ),
        AppSocialButton(
          iconPath: AssetConstants.facebook,
          onPressed: () {},
          colorBorder: AppColors.borderSilverGray,
        ),
        AppSocialButton(
          iconPath: AssetConstants.twitter,
          onPressed: () {},
          colorBorder: AppColors.borderSilverGray,
          colorIcon: colorIconApple,
        ),
      ],
    );
  }
}
