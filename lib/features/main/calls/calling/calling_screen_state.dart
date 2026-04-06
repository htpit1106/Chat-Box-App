import 'package:chatbox/data/models/enum/load_status.dart';
import 'package:equatable/equatable.dart';

class CallingScreenState extends Equatable {
  final LoadStatus callStatus;
  final int? remoteUid;

  const CallingScreenState({
    this.remoteUid,
    this.callStatus = LoadStatus.initial,
  });

  CallingScreenState copyWith({int? remoteUid, LoadStatus? callStatus}) {
    return CallingScreenState(
      remoteUid: remoteUid ?? this.remoteUid,
      callStatus: callStatus ?? this.callStatus,
    );
  }

  @override
  List<Object?> get props => [remoteUid];
}
