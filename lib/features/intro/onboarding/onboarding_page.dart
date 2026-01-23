import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/constants/ui_constants.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/widgets/button/app_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_cubit.dart';
import 'onboarding_navigator.dart';
import 'widget/or_divider.dart';
import 'widget/social_login_button.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (context) => OnboardingCubit(navigator: OnboardingNavigator(context: context)),
      child: const OnboardingPageChild(),
    );
  }
}

class OnboardingPageChild extends StatefulWidget {
  const OnboardingPageChild({super.key});

  @override
  State<OnboardingPageChild> createState() => _OnboardingPageChildState();
}

class _OnboardingPageChildState extends State<OnboardingPageChild> {
  late final OnboardingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<OnboardingCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onboarding_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: UiConstants.horizontalPaddingMedium,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AssetConstants.logSmall),
                RichText(
                  text: TextSpan(
                    text: 'Connect friends ',
                    style: AppTextStyle.white.s68.w300,
                    children: [
                      TextSpan(text: 'easily & quickly', style: AppTextStyle.white.s68.w500),
                    ],
                  ),
                ),
                Text(
                  "Our chat app is the perfect way to stay connected with friends and family.",
                  style: AppTextStyle.gray.s16,
                ),



                SocialLoginButton(),
                OrDivider(),
                AppTextButton(
                  text: "Sign up with mail",
                  textStyle: AppTextStyle.black.s16.w500,
                  onPressed: () {
                    _cubit.onPressSignUp();
                  },
                  color: Colors.white,
                ),
                GestureDetector(
                  onTap: () {
                    _cubit.onPressLogin();
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "Existing account? ",
                      style: AppTextStyle.gray.s16,

                      children: [TextSpan(text: "Log in", style: AppTextStyle.white.s16)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


}
