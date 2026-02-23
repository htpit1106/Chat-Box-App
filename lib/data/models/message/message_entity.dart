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

  MessageEntity({
    this.id,
    this.senderId,
    this.type,
    this.content,
    this.createdAt,
    this.seenBy,
  });

  factory MessageEntity.fromJson(Map<String, dynamic> json) =>
      _$MessageEntityFromJson(json);

  Map<String, dynamic> toJson() => _$MessageEntityToJson(this);
}
