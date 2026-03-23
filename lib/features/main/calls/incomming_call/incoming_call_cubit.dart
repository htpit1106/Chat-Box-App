import 'package:chatbox/features/main/calls/calls_cubit.dart';
import 'package:chatbox/features/main/calls/incomming_call/incoming_call_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IncomingCallCubit extends Cubit<IncomingCallState> {
  final CallsCubit callsCubit;

  IncomingCallCubit({required this.callsCubit}) : super(IncomingCallState());

  void acceptCall() {
    callsCubit.acceptCall();
  }

  void rejectCall() {
    callsCubit.endCall();
  }
}
