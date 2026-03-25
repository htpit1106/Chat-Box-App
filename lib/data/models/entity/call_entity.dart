import 'package:cloud_firestore/cloud_firestore.dart';

class CallEntity {
  final String? callerId;
  final String? callerName;
  final String? receiverAvatar;
  final String? receiverId;
  final String? receiverName;
  final String? callerAvatar;
  final String? channelId;
  final String? status;
  final bool? isVideo;
  final List<String?>? participants;
  final DateTime? createdAt;

  CallEntity({
    this.callerId,
    this.receiverId,
    this.channelId,
    this.status,
    this.isVideo = false,
    this.participants = const [],
    this.callerName,
    this.callerAvatar,
    this.receiverAvatar,
    this.receiverName,
    this.createdAt,
  });

  Map<String, dynamic> toMap() => {
    "caller_id": callerId,
    "receiver_id": receiverId,
    "channel_id": channelId,
    "status": status,
    "is_video": isVideo,
    "createdAt": FieldValue.serverTimestamp(),
    "participants": participants,
    "caller_name": callerName,
    "caller_avatar": callerAvatar,
    "receiver_avatar": receiverAvatar,
  };

  factory CallEntity.fromMap(Map<String, dynamic> map) {
    return CallEntity(
      callerId: map['caller_id'],
      receiverId: map['receiver_id'],
      channelId: map['channel_id'],
      status: map['status'],
      isVideo: map['is_video'],
      participants: List<String>.from(map['participants']),
      callerName: map['caller_name'],
      callerAvatar: map['caller_avatar'],
      receiverAvatar: map['receiver_avatar'],
      receiverName: map['receiver_name'],
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
    );
  }
}
