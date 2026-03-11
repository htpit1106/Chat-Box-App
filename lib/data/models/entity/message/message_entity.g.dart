// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntity _$MessageEntityFromJson(Map<String, dynamic> json) =>
    MessageEntity(
      id: json['id'] as String?,
      senderId: json['sender_id'] as String?,
      type: $enumDecodeNullable(_$MessageTypeEnumMap, json['type']),
      content: json['content'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      seenBy: (json['seen_by'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as bool),
      ),
      fileName: json['file_name'] as String?,
      fileSize: json['file_size'] as String?,
      fileUrl: json['file_url'] as String?,
      fileType: json['file_type'] as String?,
      status: json['status'] as String?,
    );

Map<String, dynamic> _$MessageEntityToJson(MessageEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.senderId,
      'type': _$MessageTypeEnumMap[instance.type],
      'content': instance.content,
      'created_at': instance.createdAt?.toIso8601String(),
      'seen_by': instance.seenBy,
      'file_name': instance.fileName,
      'file_size': instance.fileSize,
      'file_url': instance.fileUrl,
      'file_type': instance.fileType,
      'status': instance.status,
    };

const _$MessageTypeEnumMap = {
  MessageType.text: 'text',
  MessageType.image: 'image',
  MessageType.video: 'video',
  MessageType.file: 'file',
};
