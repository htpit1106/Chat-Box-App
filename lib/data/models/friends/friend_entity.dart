import 'package:json_annotation/json_annotation.dart';

part 'friend_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FriendEntity {
  String? id;
  String? conversationId;
  DateTime? createdAt;

  FriendEntity({this.id, this.conversationId,  DateTime? createdAt})
    : createdAt = createdAt ?? DateTime.now();

  factory FriendEntity.fromJson(Map<String, dynamic> json) => _$FriendEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FriendEntityToJson(this);
}
