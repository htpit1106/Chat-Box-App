import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingPageChild();
  }
}

class OnboardingPageChild extends StatefulWidget {
  const OnboardingPageChild({super.key});

  @override
  State<OnboardingPageChild> createState() => _OnboardingPageChildState();
}

class _OnboardingPageChildState extends State<OnboardingPageChild> {
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
          child: Column(
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
              Text("Our chat app is the perfect way to stay connected with friends and family.", style: AppTextStyle.gray.s16,),
            ],
          ),
        ),
      ),
    );
  }
}
