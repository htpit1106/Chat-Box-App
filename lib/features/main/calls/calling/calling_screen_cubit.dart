import 'package:chatbox/core/network/agora_rtc_service.dart';
import 'package:chatbox/features/main/calls/calling/calling_screen_state.dart';
import 'package:chatbox/features/main/calls/calls_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallingScreenCubit extends Cubit<CallingScreenState> {
  final CallsCubit callsCubit;
  final AgoraService agoraService;

  CallingScreenCubit({required this.callsCubit, required this.agoraService})
    : super(CallingScreenState());

  int? get remoteUid => agoraService.remoteUid;

  void rejectCall() {
    callsCubit.endCall();
  }
}
