import 'package:chatbox/data/models/entity/message/message_entity.dart';
import 'package:chatbox/features/main/home/message/widget/file_message.dart';
import 'package:chatbox/features/main/home/message/widget/image_message.dart';
import 'package:chatbox/features/main/home/message/widget/send_message.dart';
import 'package:flutter/material.dart';

enum MessageType { text, image, video, file }

extension MessageTypeExt on MessageType {
  Widget buildMessage({
    required MessageEntity message,
    required bool isSend,
    String? avatar,
  }) {
    switch (this) {
      case MessageType.text:
        return SendMessage(
          message: message.content,
          isSend: isSend,
          avatar: avatar,
        );

      case MessageType.file:
        return FileMessage(
          fileName: message.fileName ?? '',
          fileSize: message.fileSize ?? '',
          isSend: isSend,
          avatar: avatar,
        );
      case MessageType.image:
        return ImageMessage(
          filePath: message.fileUrl ?? '',
          isSend: isSend,
          avatar: avatar,
        );
      default:
        return Container();
    }
  }

  String? lastMessage(String? text) {
    switch (this) {
      case MessageType.text:
        return text;
      case MessageType.file:
        return 'a new file';
      case MessageType.image:
        return 'a new image';
      default:
        return '';
    }
  }
}
