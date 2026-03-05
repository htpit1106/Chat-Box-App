import 'dart:async';
import 'dart:io';

import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/core/network/supabase_service.dart';
import 'package:chatbox/core/utils/utils.dart';
import 'package:chatbox/data/models/conversation/conversation_entity.dart';
import 'package:chatbox/data/models/entity/message/message_entity.dart';
import 'package:chatbox/data/models/enum/message_type.dart';
import 'package:chatbox/data/models/user_profile/user_entity.dart';
import 'package:chatbox/data/repository/conversation_repository.dart';
import 'package:chatbox/features/main/home/message/message_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageCubit extends Cubit<MessageState> {
  final ConversationRepository conversationRepos;
  StreamSubscription? _messageSubscription;
  String? _conversationId;

  final AppCubit appCubit;
  final UserEntity friend;
  final SupabaseService supabaseService = SupabaseService();

  MessageCubit({
    required this.conversationRepos,
    required this.friend,
    required this.appCubit,
  }) : super(MessageState());

  void init(String friendId) async {
    final resultConversationId = await conversationRepos.getConversationId(
      friendId,
    );
    resultConversationId.fold((failure) {}, (conversationId) {
      _conversationId = conversationId;
      subscribeMessage(conversationId);
    });
  }

  Future<void> onUploadFilesTap() async {
    final List<File> files = await pickFiles();
    if (files.isEmpty) return;

    for (final file in files) {
      final publicUrl = await supabaseService.uploadFileToSupabase(
        file: file,
        conversationId: _conversationId!,
        folder: 'documents',
      );
      sendMessage(file: file, type: MessageType.file);
    }
    emit(state.copyWith(files: files));
  }

  @override
  Future<void> close() {
    _messageSubscription?.cancel();
    return super.close();
  }

  Future<void> sendMessage({
    String? text,
    required MessageType type,
    File? file,
    String? fileUrl,
  }) async {
    if (_conversationId == null || _conversationId!.isEmpty) {
      await _createConversation();
    }
    final message = MessageEntity(
      content: text,
      createdAt: DateTime.now(),
      type: type,
      fileName: file?.path.split('/').last,
      fileSize: file?.lengthSync().toString(),
      fileUrl: fileUrl,
      fileType: file?.path.split('.').last,
      senderId: appCubit.state.currentUser?.uid,
    );

    conversationRepos.sendMessage(
      conversationId: _conversationId!,
      message: message,
    );
  }

  Future<void> _createConversation() async {
    if (friend.uid == null) return;
    final currentUser = appCubit.state.currentUser;
    if (currentUser == null) return;

    final conversation = ConversationEntity(
      memberIds: [friend.uid!, currentUser.uid!],
      lastMessageAt: DateTime.now(),
      lastSenderId: friend.uid,
      isGroup: false,
    );
    final result = await conversationRepos.createConversation(
      conversation: conversation,
      memberIds: conversation.memberIds ?? [],
    );
    result.fold(
      (failure) {
        return;
      },
      (conversationId) {
        _conversationId = conversationId;
        subscribeMessage(conversationId);
      },
    );
  }

  void subscribeMessage(String conversationId) {
    _messageSubscription?.cancel();
    _messageSubscription = conversationRepos.getMessages(conversationId).listen(
      (result) {
        result.fold(
          (failure) {},
          (messages) => emit(state.copyWith(messages: messages)),
        );
      },
    );
  }
}
