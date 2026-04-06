import 'package:chatbox/core/error/failures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/entity/call_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CallRepository {
  Future<void> createCall(CallEntity call);

  Stream<DocumentSnapshot> listenCall(String channelId);

  Stream<Either<Failure, QuerySnapshot>> getCallHistory(String? userId);

  Future<void> updateCall(String channelId, String status);

  Stream<QuerySnapshot> listenIncomingCalls(String userId);
}

class CallRepositoryImpl extends CallRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createCall(CallEntity call) {
    final callRef = _firestore.collection('calls').doc(call.channelId);
    return callRef.set(call.toMap());
  }

  @override
  Stream<DocumentSnapshot<Object?>> listenCall(String channelId) {
    final callRef = _firestore.collection('calls').doc(channelId);
    return callRef.snapshots();
  }

  @override
  Future<void> updateCall(String channelId, String status) {
    final callRef = _firestore.collection('calls').doc(channelId);
    return callRef.update({'status': status});
  }

  @override
  Stream<QuerySnapshot<Object?>> listenIncomingCalls(String userId) {
    return _firestore
        .collection("calls")
        .where("receiver_id", isEqualTo: userId)
        .where("status", isEqualTo: "ringing")
        .snapshots();
  }

  @override
  Stream<Either<Failure, QuerySnapshot<Object?>>> getCallHistory(
    String? userId,
  ) {
    try {
      if (userId == null) {
        return Stream.value(Left(ServerFailure(message: 'User not found')));
      }
      final callRef = _firestore
          .collection("calls")
          .where("participants", arrayContains: userId)
          .snapshots();
      return callRef.map((snapshot) => Right(snapshot));
    } catch (e) {
      return Stream.value(Left(ServerFailure(message: e.toString())));
    }
  }
}
