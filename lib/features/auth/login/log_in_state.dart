import 'package:equatable/equatable.dart';

class LogInState extends Equatable {
  final bool enableLogin;

  const LogInState({required this.enableLogin});

  // copy with
  LogInState copyWith({bool? enableLogin}) {
    return LogInState(enableLogin: enableLogin ?? this.enableLogin);
  }

  @override
  List<Object?> get props => [enableLogin];
}
