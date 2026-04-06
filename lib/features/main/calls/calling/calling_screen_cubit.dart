import 'dart:async';

import 'package:chatbox/core/network/agora_rtc_service.dart';
import 'package:chatbox/features/main/calls/calling/calling_screen_state.dart';
import 'package:chatbox/features/main/calls/calls_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallingScreenCubit extends Cubit<CallingScreenState> {
  final CallsCubit callsCubit;
  final AgoraService agoraService;

  StreamSubscription? _remoteUidSub;

  CallingScreenCubit({required this.callsCubit, required this.agoraService})
    : super(CallingScreenState()) {
    _listenAgora();
  }

  void _listenAgora() {
    _remoteUidSub = agoraService.remoteUidStream.listen((uid) {
      emit(state.copyWith(remoteUid: uid));
    });
  }

  void rejectCall() {
    callsCubit.endCall();
  }

  @override
  Future<void> close() {
    _remoteUidSub?.cancel();
    return super.close();
  }
}
