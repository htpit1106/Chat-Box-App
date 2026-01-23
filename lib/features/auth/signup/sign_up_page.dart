import 'package:chatbox/core/constants/ui_constants.dart';
import 'package:chatbox/core/theme/app_colors.dart';
import 'package:chatbox/core/theme/app_text_style.dart';
import 'package:chatbox/core/utils/app_validator.dart';
import 'package:chatbox/core/widgets/button/app_text_button.dart';
import 'package:chatbox/core/widgets/text_field/app_label_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sign_up_cubit.dart';
import 'sign_up_navigator.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (context) => SignUpCubit(navigator: SignUpNavigator(context: context)),
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
      appBar: AppBar(
        title: Icon(Icons.arrow_back),
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: UiConstants.horizontalPaddingLarge,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_buildHeader(), _buildSignUpForm()],
          ),
        ),
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
          AppLabelTextField(
            label: "Your name",
            controller: _nameController,
            validator: AppValidator.validateEmpty,
          ),
          AppLabelTextField(label: "Your email", controller: _emailController),
          AppLabelTextField(
            label: "Password",
            controller: _passwordController,
            obscureText: true,
          ),
          AppLabelTextField(
            label: "Confirm Password",
            controller: _confirmPasswordController,
            obscureText: true,
          ),
          AppTextButton(
            text: "Create an account",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                print("Sign up");
              }
            },
            color: AppColors.buttonLightGray,
            textStyle: AppTextStyle.gray.s14.w500,
          )
        ],
      ),
    );
  }


}
