import 'package:cloud_firestore/cloud_firestore.dart';

class CallEntity {
  final String? callerId;
  final String? receiverId;
  final String? channelId;
  final String? status;
  final bool? isVideo;
  final List<String>? participants;

  CallEntity({
    this.callerId,
    this.receiverId,
    this.channelId,
    this.status,
    this.isVideo = false,
    this.participants,
  });

  Map<String, dynamic> toMap() => {
    "callerId": callerId,
    "receiverId": receiverId,
    "channelId": channelId,
    "status": status,
    "isVideo": isVideo,
    "createdAt": FieldValue.serverTimestamp(),
    "participants": participants,
  };

  factory CallEntity.fromMap(Map<String, dynamic> map) {
    return CallEntity(
      callerId: map['callerId'],
      receiverId: map['receiverId'],
      channelId: map['channelId'],
      status: map['status'],
      isVideo: map['isVideo'],
      participants: List<String>.from(map['participants']),
    );
  }
}
