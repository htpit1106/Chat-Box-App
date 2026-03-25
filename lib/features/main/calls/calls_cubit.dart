import 'dart:async';
import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/core/network/agora_rtc_service.dart';
import 'package:chatbox/data/models/entity/call_entity.dart';
import 'package:chatbox/data/repository/call_repository.dart';
import 'package:chatbox/features/main/calls/calls_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'calls_navigator.dart';

class CallsCubit extends Cubit<CallsState> {
  final AppCubit appCubit;
  final CallRepository callRepos;
  final AgoraService agora;
  StreamSubscription? _incomingSub;
  StreamSubscription? _callSub;
  StreamSubscription? _callHistory;
  final CallsNavigator navigator;

  CallsCubit({
    required this.callRepos,
    required this.appCubit,
    required this.agora,
    required this.navigator,
  }) : super(CallsState());

  Future<void> loadCalls() async {
    _callHistory?.cancel();
    emit(state.copyWith(status: CallStatus.loading));
    try {
      _callHistory = callRepos
          .getCallHistory(appCubit.state.currentUser?.uid)
          .listen((result) {
            result.fold((left) {}, (snapshots) {
              final calls = snapshots.docs
                  .map(
                    (doc) =>
                        CallEntity.fromMap(doc.data() as Map<String, dynamic>),
                  )
                  .toList();
              emit(state.copyWith(calls: calls));
            });
          });
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
      status: "ringing",
      isVideo: isVideo,
    );

    await callRepos.createCall(call);
    emit(state.copyWith(status: CallStatus.ringing, currentCall: call));
    _listenCall(channelId);
  }

  void _listenCall(String channelId) {
    _callSub?.cancel();

    _callSub = callRepos.listenCall(channelId).listen((snapshot) async {
      if (!snapshot.exists || snapshot.data() == null) return;

      final call = CallEntity.fromMap(snapshot.data() as Map<String, dynamic>);

      if (call.status == "calling") {
        if (call.channelId == null) return;
        await agora.join(call.channelId!);
        navigateToCallingScreen();
        emit(state.copyWith(status: CallStatus.calling, currentCall: call));
      }

      if (call.status == "ended") {
        await agora.leave();
        emit(state.copyWith(status: CallStatus.ended));
      }
      if (call.status == "rejected") {
        emit(state.copyWith(status: CallStatus.ended));
      }
    });
  }

  void navigateToCallingScreen() {
    navigator.goToCallingScreen();
  }

  // 📲 Incoming call listener
  void listenIncoming(String userId) {
    _incomingSub = callRepos.listenIncomingCalls(userId).listen((snapshot) {
      if (snapshot.docs.isEmpty) return;

      final doc = snapshot.docs.first;
      final call = CallEntity.fromMap(doc.data() as Map<String, dynamic>);
      emit(state.copyWith(status: CallStatus.ringing, currentCall: call));
      if (call.channelId == null) return;
      navigator.showIncomingCall(call);
      _listenCall(call.channelId!);
    });
  }

  /// ✅ Accept call
  Future<void> acceptCall() async {
    final call = state.currentCall!;
    if (call.channelId == null) return;
    await callRepos.updateCall(call.channelId!, "calling");
    emit(state.copyWith(status: CallStatus.calling));
  }

  Future<void> endCall() async {
    final call = state.currentCall;
    if (call == null || call.channelId == null) return;
    if (call.status == "calling") {
      await callRepos.updateCall(call.channelId!, "ended");
      await agora.leave();
      emit(state.copyWith(status: CallStatus.ended));
    } else {
      await callRepos.updateCall(call.channelId!, "rejected");
      emit(state.copyWith(status: CallStatus.ended));
    }
  }

  @override
  Future<void> close() {
    _incomingSub?.cancel();
    _callSub?.cancel();
    return super.close();
  }
}
