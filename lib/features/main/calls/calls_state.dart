import 'package:chatbox/data/models/entity/call_entity.dart';
import 'package:equatable/equatable.dart';

enum CallStatus {
  initial,
  loading,
  success,
  calling,
  ringing,
  connected,
  ended,
  error,
}

class CallsState extends Equatable {
  final CallStatus status;
  final List<CallEntity> calls;
  final CallEntity? currentCall;
  final String? error;
  const CallsState({
    this.status = CallStatus.initial,
    this.calls = const [],
    this.currentCall,
    this.error,
  });
  CallsState copyWith({
    CallStatus? status,
    List<CallEntity>? calls,
    CallEntity? currentCall,
    String? error,
  }) {
    return CallsState(
      status: status ?? this.status,
      calls: calls ?? this.calls,
      currentCall: currentCall ?? this.currentCall,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, calls, currentCall, error];
}
