import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/features/main/settings/settings_navigator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final AppCubit appCubit;
  final SettingsNavigator navigator;

  SettingsCubit({required this.appCubit, required this.navigator})
    : super(SettingsState());

  void init() {}

  void navigateToProfile() {
    navigator.goToProfile();
  }
}
