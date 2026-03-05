import 'dart:io';

import 'package:chatbox/data/models/entity/message/message_entity.dart';
import 'package:equatable/equatable.dart';

class MessageState extends Equatable {
  final List<MessageEntity> messages;
  final List<File> files;

  const MessageState({this.messages = const [], this.files = const []});

  MessageState copyWith({List<MessageEntity>? messages, List<File>? files}) {
    return MessageState(
      messages: messages ?? this.messages,
      files: files ?? this.files,
    );
  }

  @override
  List<Object?> get props => [messages, files];
}
