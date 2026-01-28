import 'package:json_annotation/json_annotation.dart';
part  'conversation_entity.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ConversationEntity {
  String? id;
  List<String>? memberIds;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final String? lastSenderId;
  final bool? isGroup;

  ConversationEntity ({
    this.id,
    this.memberIds,
    this.lastMessage,
    this.lastMessageAt,
    this.lastSenderId,
    this.isGroup,
  });

  factory ConversationEntity.fromJson(Map<String, dynamic> json) => _$ConversationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$ConversationEntityToJson(this);



}

// ?Stream<List<Conversation>> getConversations();
// Stream<List<Message>> getMessages(String conversationId);
// Future<void> sendMessage(Message message);