import 'dart:async';

import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/core/network/agora_rtc_service.dart';
import 'package:chatbox/data/models/entity/call_entity.dart';
import 'package:chatbox/data/repository/call_repository.dart';
import 'package:chatbox/features/main/calls/calls_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calls_navigator.dart';

class CallsCubit extends Cubit<CallsState> {
  final AppCubit appCubit;
  final CallRepository callRepos;
  final AgoraService agora;
  StreamSubscription? _incomingSub;
  final CallsNavigator navigator;

  CallsCubit({
    required this.callRepos,
    required this.appCubit,
    required this.agora,
    required this.navigator,
  }) : super(CallsState());

  /// 📥 Load lịch sử cuộc gọi
  Future<void> loadCalls() async {
    emit(state.copyWith(status: CallStatus.loading));

    try {
      // final calls = await firestore.getCallHistory(); // bạn tự implement
      emit(
        state.copyWith(
          status: CallStatus.success,
          // calls: calls,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: CallStatus.error, error: e.toString()));
    }
  }

  // start call
  Future<void> startCall({
    required String receiverId,
    required bool isVideo,
  }) async {
    final channelId = DateTime.now().millisecondsSinceEpoch.toString();
    final callerId = appCubit.state.currentUser?.uid;

    if (callerId == null) return;

    final call = CallEntity(
      callerId: callerId,
      receiverId: receiverId,
      channelId: channelId,
      status: "calling",
      isVideo: isVideo,
    );

    await callRepos.createCall(call);
    emit(state.copyWith(status: CallStatus.calling, currentCall: call));

    _listenCall(channelId);
  }

  void _listenCall(String channelId) {
    callRepos.listenCall(channelId).listen((snapshot) async {
      final call = CallEntity.fromMap(snapshot.data() as Map<String, dynamic>);

      if (call.status == "accepted") {
        await agora.join(call.channelId);

        emit(state.copyWith(status: CallStatus.connected, currentCall: call));
      }

      if (call.status == "ended") {
        await agora.leave();

        emit(state.copyWith(status: CallStatus.ended));
      }
    });
  }

  void navigateToCallingScreen(BuildContext context) {
    navigator.goToCallingScreen(context);
  }

  /// 📲 Incoming call listener
  // void listenIncoming(String userId) {
  //   _incomingSub = callRepos.listenIncomingCalls(userId).listen((snapshot) {
  //     final call = CallEntity.fromMap(snapshot);
  //
  //     emit(state.copyWith(
  //       status: CallStatus.ringing,
  //       currentCall: call,
  //     ));
  //   });
  // }

  /// ✅ Accept call
  Future<void> acceptCall() async {
    final call = state.currentCall!;
    await callRepos.updateCall(call.channelId, "accepted");

    await agora.join(call.channelId);

    emit(state.copyWith(status: CallStatus.connected));
  }

  // /// ❌ Reject / End
  // Future<void> endCall() async {
  //   final call = state.currentCall;
  //
  //   if (call != null) {
  //     await callRepos.endCall(call.channelId);
  //     await agora.leave();
  //   }
  //
  //   emit(state.copyWith(status: CallStatus.ended));
  // }

  @override
  Future<void> close() {
    _incomingSub?.cancel();
    return super.close();
  }
}
