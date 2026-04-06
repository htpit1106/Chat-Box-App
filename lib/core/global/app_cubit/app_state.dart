part of 'app_cubit.dart';

class AppState extends Equatable {
  // status
  final LoadStatus loadLogoutStatus;
  final LoadStatus initDataStatus;
  final Language currentLanguage;
  final UserEntity? currentUser;

  const AppState({
    this.currentLanguage = AppConfigs.defaultLanguage,
    this.currentUser,
    this.loadLogoutStatus = LoadStatus.initial,
    this.initDataStatus = LoadStatus.initial,
  });

  @override
  List<Object?> get props => [
    currentLanguage,
    currentUser,
    loadLogoutStatus,
    initDataStatus,
  ];

  AppState copyWith({
    Language? currentLanguage,
    UserEntity? currentUser,
    LoadStatus? loadLogoutStatus,
    LoadStatus? initDataStatus,
  }) {
    return AppState(
      currentLanguage: currentLanguage ?? this.currentLanguage,
      currentUser: currentUser ?? this.currentUser,
      loadLogoutStatus: loadLogoutStatus ?? this.loadLogoutStatus,
      initDataStatus: initDataStatus ?? this.initDataStatus,
    );
  }
}
