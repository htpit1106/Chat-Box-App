import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final AppCubit appCubit;
  SettingsCubit({required this.appCubit}) : super(SettingsState());
  void init() {}
}
