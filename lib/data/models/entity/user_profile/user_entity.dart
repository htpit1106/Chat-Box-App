import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class UserEntity {
  final String? uid;
  final String? email;
  final String? name;
  final String? avatarUrl;
  final bool? isOnline;
  final DateTime? lastSeen;
  final String? fcmToken;
  final DateTime? createdAt;
  final String? birthday;

  UserEntity({
    this.uid,
    this.email,
    this.name,
    this.avatarUrl,
    this.isOnline = true,
    this.lastSeen,
    this.fcmToken,
    this.birthday,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  // copy with
  UserEntity copyWith({
    String? uid,
    String? email,
    String? name,
    String? avatarUrl,
    bool? isOnline,
    DateTime? lastSeen,
    String? fcmToken,
    String? birthday,
    DateTime? createdAt,
  }) {
    return UserEntity(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      name: name ?? this.name,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isOnline: isOnline ?? this.isOnline,
      lastSeen: lastSeen ?? this.lastSeen,
      fcmToken: fcmToken ?? this.fcmToken,
      birthday: birthday ?? this.birthday,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);

  // firestore mapper
  factory UserEntity.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserEntity(
      uid: doc.id,
      email: data['email'],
      name: data['name'],
      avatarUrl: data['avatar_url'],
      isOnline: data['is_online'],
      birthday: data['birthday'],
      lastSeen: data['last_seen'] == null
          ? null
          : DateTime.parse(data['last_seen'] as String),
      fcmToken: data['fcm_token'],
    );
  }
}
