import 'package:chatbox/data/models/user_profile/profile_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

abstract class UserRepository {
  Future<void> createUserProfile(ProfileEntity profile);

  Future<ProfileEntity?> getProfile(String uid);
}

class UserRepositoryImpl implements UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> createUserProfile(ProfileEntity profile) async {
    try {
      if (profile.uid == null) return ;
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
  Future<ProfileEntity?> getProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (!doc.exists) return null;
    return ProfileEntity.fromJson(doc.data()!);
  }

}