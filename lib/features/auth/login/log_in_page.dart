import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/features/intro/onboarding/widget/or_divider.dart';
import 'package:chatbox/features/intro/onboarding/widget/social_login_button.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class LogInPageChild extends StatefulWidget {
  const LogInPageChild({super.key});

  @override
  State<LogInPageChild> createState() => _LogInPageChildState();
}

class _LogInPageChildState extends State<LogInPageChild> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
  Widget _buildHeader() {
    return Column(
      spacing: 16,
      children: [
        Text("Log in to Chatbox", style: AppTextStyle.black.s18.bold),
        Text(
          "Welcome back! Sign in using your social account or email to continue us",
          textAlign: TextAlign.center,
          style: AppTextStyle.gray.s14,
        ),
        const SizedBox(height: 10),
        SocialLoginButton(colorIconApple: Colors.black),
        const SizedBox(height: 10),
        OrDivider(),
      ],
    );
  }
}
