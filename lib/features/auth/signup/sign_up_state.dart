import 'package:equatable/equatable.dart';

class SignUpState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  const SignUpState({
    this.isLoading = false,
    this.isSuccess = false,
    this.error,
  });
  // copy with
  SignUpState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? error,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }


  @override
  List<Object?> get props => [];
}