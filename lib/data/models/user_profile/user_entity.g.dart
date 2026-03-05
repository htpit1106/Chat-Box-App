// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
  uid: json['uid'] as String?,
  email: json['email'] as String?,
  name: json['name'] as String?,
  avatarUrl: json['avatar_url'] as String?,
  isOnline: json['is_online'] as bool? ?? true,
  lastSeen: json['last_seen'] == null
      ? null
      : DateTime.parse(json['last_seen'] as String),
  fcmToken: json['fcm_token'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'name': instance.name,
      'avatar_url': instance.avatarUrl,
      'is_online': instance.isOnline,
      'last_seen': instance.lastSeen?.toIso8601String(),
      'fcm_token': instance.fcmToken,
      'created_at': instance.createdAt?.toIso8601String(),
    };
