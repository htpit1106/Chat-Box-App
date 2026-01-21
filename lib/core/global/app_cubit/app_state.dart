part of 'app_cubit.dart';

class AppState extends Equatable {

  final Language currentLanguage;

  const AppState({
    this.currentLanguage = AppConfigs.defaultLanguage,
  });

  @override
  List<Object?> get props => [currentLanguage];

  AppState copyWith({
    Language? currentLanguage,
  }) {
    return AppState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
    );
  }

}