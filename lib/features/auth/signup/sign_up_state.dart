import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final bool enableSignUp;

  const SignUpState({required this.enableSignUp});

  // copy with
  SignUpState copyWith({bool? enableSignUp}) {
    return SignUpState(enableSignUp: enableSignUp ?? this.enableSignUp);
  }

  @override
  List<Object?> get props => [enableSignUp];
}
