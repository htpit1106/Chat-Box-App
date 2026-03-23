import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class UserRepository {
  Future<void> createUserProfile(UserEntity profile);

  Future<UserEntity?> getProfile(String uid);

  // search by name and email
  Future<Map<String, List<UserEntity>>> searchUsersByNameOrEmail(String query);

  Future<UserEntity?> getCurrentUserProfile();

  Future<void> updateProfile(UserEntity? profile);
}

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createUserProfile(UserEntity profile) async {
    try {
      if (profile.uid == null) return;
      final doc = _firestore.collection('users').doc(profile.uid);
      final snapshot = await doc.get();
      if (!snapshot.exists) {
        await doc.set(profile.toJson());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Future<UserEntity?> getProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return UserEntity.fromFireStore(doc);
  }

  Future<UserEntity?> getCurrentUserProfile() async {
    final currentUid = FirebaseAuth.instance.currentUser?.uid;
    if (currentUid == null) return null;
    final doc = await _firestore.collection('users').doc(currentUid).get();
    if (!doc.exists) return null;
    return UserEntity.fromFireStore(doc);
  }

  @override
  Future<Map<String, List<UserEntity>>> searchUsersByNameOrEmail(
    String query,
  ) async {
    // 1. get list your friend from sub-user collection - by name , email
    // 2. get user not your friend from user - by name, email

    if (query.isEmpty) {
      return {'friend': [], 'non_friend': []};
    }

    final currentUid = FirebaseAuth.instance.currentUser?.uid;
    final q = query.toLowerCase();

    final friendsSnap = await _firestore
        .collection('users')
        .doc(currentUid)
        .collection('friends')
        .get();
    final friendUids = friendsSnap.docs.map((e) => e.id).toList();
    // query users by name
    final usersByNameSnap = await _firestore
        .collection('users')
        .orderBy('name_lower')
        .startAt([q])
        .endAt(['$q\uf8ff'])
        .limit(20)
        .get();

    // query user by email
    final usersByEmailSnap = await _firestore
        .collection('users')
        .orderBy('email_lower')
        .startAt([q])
        .endAt(['$q\uf8ff'])
        .limit(20)
        .get();

    ///  merge 2 list users
    final Map<String, UserEntity> userMap = {};
    final Map<String, UserEntity> friendMap = {};

    for (final doc in [...usersByNameSnap.docs, ...usersByEmailSnap.docs]) {
      if (doc.id == currentUid) continue;
      if (friendUids.contains(doc.id)) {
        friendMap[doc.id] = UserEntity.fromFireStore(doc);
        continue;
      }
      userMap[doc.id] = UserEntity.fromFireStore(doc);
    }
    final users = {
      'friend': friendMap.values.toList(),
      'non_friend': userMap.values.toList(),
    };

    return users;
  }

  @override
  Future<void> updateProfile(UserEntity? profile) async {
    if (profile == null) return;
    await _firestore
        .collection('users')
        .doc(profile.uid)
        .update(profile.toJson());
  }
}
