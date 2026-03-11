import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FriendEntity {
  @JsonKey(ignore: true)
  String? id;

  String? conversationId;
  DateTime? createdAt;

  FriendEntity({this.id, this.conversationId, DateTime? createdAt})
    : createdAt = createdAt ?? DateTime.now();

  factory FriendEntity.fromJson(Map<String, dynamic> json) =>
      _$FriendEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FriendEntityToJson(this);

  factory FriendEntity.fromFireStore(DocumentSnapshot doc) {
    return FriendEntity(
      id: doc.id,
      conversationId: doc['conversation_id'],
      createdAt: doc['created_at'] == null
          ? null
          : DateTime.parse(doc['created_at']),
    );
  }
}
