import 'package:chatbox/features/main/calls/calling/calling_screen_state.dart';
import 'package:chatbox/features/main/calls/calls_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallingScreenCubit extends Cubit<CallingScreenState> {
  final CallsCubit callsCubit;

  CallingScreenCubit({required this.callsCubit}) : super(CallingScreenState());

  void rejectCall() {
    callsCubit.endCall();
  }
}
