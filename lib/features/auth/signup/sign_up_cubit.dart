import 'package:chatbox/features/auth/signup/sign_up_navigator.dart';
import 'package:chatbox/features/auth/signup/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpNavigator navigator;
  SignUpCubit({required this.navigator}) : super(SignUpState());
}
