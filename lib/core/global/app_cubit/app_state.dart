part of 'app_cubit.dart';

class AppState extends Equatable {
  final Language currentLanguage;
  final UserEntity? currentUser;

  const AppState({
    this.currentLanguage = AppConfigs.defaultLanguage,
    this.currentUser,
  });

  @override
  List<Object?> get props => [currentLanguage, currentUser];

  AppState copyWith({Language? currentLanguage, UserEntity? currentUser}) {
    return AppState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
