// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FriendEntity _$FriendEntityFromJson(Map<String, dynamic> json) => FriendEntity(
  conversationId: json['conversation_id'] as String?,
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
);

Map<String, dynamic> _$FriendEntityToJson(FriendEntity instance) =>
    <String, dynamic>{
      'conversation_id': instance.conversationId,
      'created_at': instance.createdAt?.toIso8601String(),
    };
