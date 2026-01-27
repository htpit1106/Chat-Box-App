import 'package:chatbox/core/constants/ui_constants.dart';
import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/utils/app_validator.dart';
import 'package:chatbox/core/widgets/app_bar/app_bar_widget.dart';
import 'package:chatbox/core/widgets/button/app_text_button.dart';
import 'package:chatbox/core/widgets/text_field/app_label_text_field.dart';
import 'package:chatbox/features/intro/onboarding/widget/or_divider.dart';
import 'package:chatbox/features/intro/onboarding/widget/social_login_button.dart';
import 'package:chatbox/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'log_in_cubit.dart';
import 'log_in_navigator.dart';
import 'log_in_state.dart';

class LogInPage extends StatelessWidget {
  const LogInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogInCubit>(
      create: (context) {
        return LogInCubit(
          navigator: LogInNavigator(context: context),
          authRepository: context.read<AuthRepository>(),
        );
      },
      child: const LogInPageChild(),
    );
  }
}

class LogInPageChild extends StatefulWidget {
  const LogInPageChild({super.key});

  @override
  State<LogInPageChild> createState() => _LogInPageChildState();
}

class _LogInPageChildState extends State<LogInPageChild> {
  late final LogInCubit _cubit;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<LogInCubit>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: UiConstants.horizontalPaddingLarge,
          child: Column(spacing: 30, children: [_buildHeader(), _buildForm()]),
        ),
      ),
      bottomNavigationBar: _buildFooter(),
    );
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
        10.height,
        SocialLoginButton(colorIconApple: Colors.black),
        10.height,
        OrDivider(),
      ],
    );
  }

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 30,
        children: [
          AppLabelTextField(
            label: "Your email",
            controller: _emailController,
            validator: AppValidator.validateEmail,
            onChanged: (value) {
              _cubit.changeEnableLogin(value.isNotEmpty);
            }
          ),
          AppLabelTextField(
            label: "Password",
            controller: _passwordController,
            obscureText: true,
            validator: AppValidator.validateEmpty,
            onChanged: (value) {
              _cubit.changeEnableLogin(value.isNotEmpty);
            }

          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return SafeArea(
      child: Padding(
        padding: UiConstants.horizontalPaddingLarge,
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<LogInCubit, LogInState>(
              buildWhen: (previous, current) => previous.enableLogin != current.enableLogin,
              builder: (context, state) {
                return AppTextButton(
                  enable: state.enableLogin,
                  text: "Log in",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _cubit.onPressLogIn(
                        email: _emailController.text,
                        password: _passwordController.text,);
                    }
                  },
                  color: AppColors.buttonLightGray,
                  textStyle: AppTextStyle.gray.s14.w500,
                );
              },
            ),
            Text("Forgot password?", style: AppTextStyle.primary.s12),
          ],
        ),
      ),
    );
  }
}
