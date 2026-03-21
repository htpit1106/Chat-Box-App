import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/entity/call_entity.dart';

abstract class CallRepository {
  Future<void> createCall(CallEntity call);

  Stream<DocumentSnapshot> listenCall(String channelId);

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
    throw UnimplementedError();
  }

  @override
  Stream<QuerySnapshot<Object?>> listenIncomingCalls(String userId) {
    return _firestore
        .collection("call")
        .where("receiverId", isEqualTo: userId)
        .where("status", isEqualTo: "calling")
        .snapshots();
  }
}
