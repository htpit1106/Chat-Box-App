import 'package:chatbox/features/main/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainState(currentPage: 0));

  void changePage(int pageIndex) {
    emit(state.copyWith(currentPage: pageIndex));
  }
}
