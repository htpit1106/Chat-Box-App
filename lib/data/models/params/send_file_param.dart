import 'dart:io';

class SendFileParam {
  final int conversationId;
  final File file;
  final String senderId;
  SendFileParam({
    required this.conversationId,
    required this.file,
    required this.senderId,
  });
}
