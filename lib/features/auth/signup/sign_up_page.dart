import 'package:chatbox/core/constants/ui_constants.dart';
import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/utils/app_validator.dart';
import 'package:chatbox/core/widgets/app_bar/app_bar_widget.dart';
import 'package:chatbox/core/widgets/button/app_text_button.dart';
import 'package:chatbox/core/widgets/text_field/app_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_cubit.dart';
import 'sign_up_navigator.dart';
import 'sign_up_state.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => SignUpCubit(
        navigator: SignUpNavigator(context: context),
        authRepositor: context.read(),
        userRepository: context.read(),
      ),
      child: const SignUpPageChild(),
    );
  }
}

class SignUpPageChild extends StatefulWidget {
  const SignUpPageChild({super.key});

  @override
  State<SignUpPageChild> createState() => _SignUpPageChildState();
}

class _SignUpPageChildState extends State<SignUpPageChild> {
  late final SignUpCubit _cubit;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<SignUpCubit>(context);
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: Padding(
        padding: UiConstants.horizontalPaddingLarge,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_buildHeader(), _buildSignUpForm()],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: 24.paddingAll,
        child: _buildFooter(),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      spacing: 16,
      children: [
        Text("Sign up with Email", style: AppTextStyle.black.s18.bold),
        Text(
          "Get chatting with friends and family today by signing up for our chat app!",
          textAlign: TextAlign.center,
          style: AppTextStyle.gray.s14,
        ),
      ],
    );
  }

  Widget _buildSignUpForm() {
    return Form(
      key: _formKey,
      child: Column(
        spacing: 30,
        children: [
          const SizedBox(height: 30),

          AppLabelTextField(
            label: "Your name",
            controller: _nameController,
            validator: AppValidator.validateEmpty,
            onChanged: (value) => _cubit.changeEnableSignUp(value.isNotEmpty),
          ),
          AppLabelTextField(
            label: "Your email",
            controller: _emailController,
            validator: AppValidator.validateEmail,
            onChanged: (value) => _cubit.changeEnableSignUp(value.isNotEmpty),
          ),
          AppLabelTextField(
            label: "Password",
            controller: _passwordController,
            obscureText: true,
            validator: AppValidator.validateEmpty,
            onChanged: (value) => _cubit.changeEnableSignUp(value.isNotEmpty),
          ),
          AppLabelTextField(
            label: "Confirm Password",
            controller: _confirmPasswordController,
            obscureText: true,
            validator: (value) => AppValidator.validateConfirmPassword(
              value,
              _passwordController.text,
            ),
            onChanged: (value) => _cubit.changeEnableSignUp(value.isNotEmpty),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) =>
          previous.enableSignUp != current.enableSignUp,
      builder: (context, state) {
        return AppTextButton(
          text: "Create an account",
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _cubit.onPressSignUp(
                email: _emailController.text,
                password: _passwordController.text,
                name: _nameController.text,
              );
            }
          },
          enable: state.enableSignUp,
          color: AppColors.buttonLightGray,
          textStyle: AppTextStyle.gray.s14.w500,
        );
      },
    );
  }
}
