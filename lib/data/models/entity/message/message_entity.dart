import 'package:chatbox/data/models/enum/message_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'message_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class MessageEntity {
  String? id;
  String? senderId;
  MessageType? type;
  String? content;
  DateTime? createdAt;
  final Map<String, bool>? seenBy;
  final String? fileName;
  final String? fileSize;
  final String? fileUrl;
  final String? fileType;
  final String? status;
  MessageEntity({
    this.id,
    this.senderId,
    this.type,
    this.content,
    this.createdAt,
    this.seenBy,
    this.fileName,
    this.fileSize,
    this.fileUrl,
    this.fileType,
    this.status,
  });

  factory MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MessageEntityToJson(this);
}
