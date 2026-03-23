import 'package:cloud_firestore/cloud_firestore.dart';

class CallEntity {
  final String callerId;
  final String receiverId;
  final String channelId;
  final String status;
  final bool isVideo;

  CallEntity({
    required this.callerId,
    required this.receiverId,
    required this.channelId,
    required this.status,
    required this.isVideo,
  });

  Map<String, dynamic> toMap() => {
    "callerId": callerId,
    "receiverId": receiverId,
    "channelId": channelId,
    "status": status,
    "isVideo": isVideo,
    "createdAt": FieldValue.serverTimestamp(),
  };

  factory CallEntity.fromMap(Map<String, dynamic> map) {
    return CallEntity(
      callerId: map['callerId'],
      receiverId: map['receiverId'],
      channelId: map['channelId'],
      status: map['status'],
      isVideo: map['isVideo'],
    );
  }
}
