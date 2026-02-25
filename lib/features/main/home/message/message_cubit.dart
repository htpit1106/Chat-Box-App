import 'dart:async';

import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/data/models/conversation/conversation_entity.dart';
import 'package:chatbox/data/models/message/message_entity.dart';
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

  void sendMessage(MessageEntity message) async {
    if (_conversationId == null || _conversationId!.isEmpty) {
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

    conversationRepos.sendMessage(
      conversationId: _conversationId!,
      message: message,
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
