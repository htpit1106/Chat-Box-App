// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversationEntity _$ConversationEntityFromJson(Map<String, dynamic> json) =>
    ConversationEntity(
      id: json['id'] as String?,
      memberIds: (json['member_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastMessage: json['last_message'] as String?,
      lastMessageAt: json['last_message_at'] == null
          ? null
          : DateTime.parse(json['last_message_at'] as String),
      lastSenderId: json['last_sender_id'] as String?,
      isGroup: json['is_group'] as bool?,
    );

Map<String, dynamic> _$ConversationEntityToJson(ConversationEntity instance) =>
    <String, dynamic>{
      'member_ids': instance.memberIds,
      'last_message': instance.lastMessage,
      'last_message_at': instance.lastMessageAt?.toIso8601String(),
      'last_sender_id': instance.lastSenderId,
      'is_group': instance.isGroup,
    };
