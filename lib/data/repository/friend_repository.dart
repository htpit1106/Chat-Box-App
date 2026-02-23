import 'package:chatbox/data/models/friends/friend_entity.dart'
    show FriendEntity;
import 'package:chatbox/data/models/user_profile/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class FriendRepository {
  Future<List<UserEntity>> getOnlineFriends();

  Future<void> addFriend(String uid);

  // friend has chat conversation;
  Future<List<FriendEntity>> getChattedFriends();
}

class FriendRepositoryImpl implements FriendRepository {
  final _firestore = FirebaseFirestore.instance;
  final currentUid = FirebaseAuth.instance.currentUser?.uid;

  @override
  Future<void> addFriend(String uid) async {
    try {
      if (currentUid == null) return;
      if (uid.isEmpty) return;
      await _firestore
          .collection('users')
          .doc(currentUid)
          .collection('friends')
          .doc(uid)
          .set({
            'created_at': DateTime.now().toString(),
            'conversation_id': null,
          });
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('friends')
          .doc(currentUid)
          .set({
            'created_at': DateTime.now().toString(),
            'conversation_id': null,
          });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<List<UserEntity>> getOnlineFriends() async {
    if (currentUid == null) return [];
    final snapFriends = await _firestore
        .collection('users')
        .doc(currentUid)
        .collection('friends')
        .get();
    final List<UserEntity> friends = [];
    for (final doc in snapFriends.docs) {
      final friend = await _firestore.collection('users').doc(doc.id).get();
      friends.add(UserEntity.fromFireStore(friend));
    }
    return friends;
  }

  @override
  Future<List<FriendEntity>> getChattedFriends() {
    // TODO: implement getFriendsChat
    throw UnimplementedError();
  }
}
