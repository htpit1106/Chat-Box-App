import 'package:chatbox/data/models/user_profile/profile_entity.dart';
import 'package:chatbox/features/auth/signup/sign_up_navigator.dart';
import 'package:chatbox/features/auth/signup/sign_up_state.dart';
import 'package:chatbox/repository/auth_repository.dart';
import 'package:chatbox/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpNavigator navigator;
  final AuthRepository authRepositor;
  final UserRepository userRepository;

  SignUpCubit({required this.navigator, required this.authRepositor, required this.userRepository})
    : super(SignUpState());

  Future<void> onPressSignUp({
    required String email,
    required String password,
    required String name,
  }) async {
    emit(state.copyWith(isLoading: true));
    try {
      final credential = await authRepositor.signUp(email: email, password: password);
      final uid = credential.user?.uid;
      if (uid == null) {
        emit(state.copyWith(isLoading: false, error: "Something went wrong"));
        return;
      }
      final profile = ProfileEntity(uid: uid, email: email, name: name);
      await userRepository.createUserProfile(profile);
      emit(state.copyWith(isLoading: false, isSuccess: true));
      navigator.openHome();
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: "Something went wrong"));
    }
  }
}
