import 'package:chatbox/data/models/message/message_entity.dart';
import 'package:equatable/equatable.dart';

class MessageState extends Equatable {
  final List<MessageEntity> messages;

  const MessageState({this.messages = const []});

  MessageState copyWith({List<MessageEntity>? messages}) {
    return MessageState(messages: messages ?? this.messages);
  }

  @override
  List<Object?> get props => [messages];
}
