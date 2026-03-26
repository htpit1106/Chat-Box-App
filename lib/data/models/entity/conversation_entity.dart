import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversation_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ConversationEntity {
  String? id;
  List<String>? memberIds;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final String? lastSenderId;
  final bool? isGroup;

  ConversationEntity({
    this.id,
    this.memberIds,
    this.lastMessage,
    this.lastMessageAt,
    this.lastSenderId,
    this.isGroup,
  });

  // copy with
  ConversationEntity copyWith({
    String? id,
    List<String>? memberIds,
    String? lastMessage,
    DateTime? lastMessageAt,
    String? lastSenderId,
    bool? isGroup,
  }) {
    return ConversationEntity(
      id: id ?? this.id,
      memberIds: memberIds ?? this.memberIds,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      lastSenderId: lastSenderId ?? this.lastSenderId,
      isGroup: isGroup ?? this.isGroup,
    );
  }

  factory ConversationEntity.fromJson(Map<String, dynamic> json) =>
      _$ConversationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationEntityToJson(this);

  Map<String, dynamic> toJonUpdate() {
    final data = toJson();
    // remove null field
    data.removeWhere((key, value) => value == null);
    return data;
  }

  factory ConversationEntity.fromFireStore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ConversationEntity(
      id: doc.id,
      memberIds: (data['member_ids'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      lastMessage: data['last_message'],
      lastMessageAt: data['last_message_at'] == null
          ? null
          : DateTime.parse(data['last_message_at'] as String),
      lastSenderId: data['last_sender_id'],
      isGroup: data['is_group'],
    );
  }
}

// ?Stream<List<Conversation>> getConversations();
// Stream<List<Message>> getMessages(String conversationId);
// Future<void> sendMessage(Message message);
