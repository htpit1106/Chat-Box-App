import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/global/app_cubit/app_cubit.dart';
import 'package:chatbox/core/widgets/app_bar/app_bar_widget.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:chatbox/data/models/enum/message_type.dart';
import 'package:chatbox/data/models/message/message_entity.dart';
import 'package:chatbox/data/models/user_profile/user_entity.dart';
import 'package:chatbox/features/main/home/message/message_cubit.dart';
import 'package:chatbox/features/main/home/message/widget/chat_input.dart';
import 'package:chatbox/features/main/home/widget/avatar_with_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'message_state.dart';
import 'widget/receive_message.dart';
import 'widget/send_message.dart';

class MessagePage extends StatelessWidget {
  final UserEntity friend;

  const MessagePage({super.key, required this.friend});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessageCubit(
        conversationRepos: context.read(),
        friend: friend,
        appCubit: context.read(),
      ),
      child: MessagePageChild(friend: friend),
    );
  }
}

class MessagePageChild extends StatefulWidget {
  final UserEntity friend;

  const MessagePageChild({super.key, required this.friend});

  @override
  State<MessagePageChild> createState() => _MessagePageChildState();
}

class _MessagePageChildState extends State<MessagePageChild> {
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();
  late final MessageCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MessageCubit>();
    _cubit.init(widget.friend.uid.toString());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      scrollToBottom();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: Row(
          spacing: 10,
          children: [
            AvatarWithStatus(avatar: widget.friend.avatarUrl),
            Text(widget.friend.name ?? "unknow"),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: AppAssetImage(path: AssetConstants.call),
          ),
          IconButton(
            onPressed: () {},
            icon: AppAssetImage(path: AssetConstants.video),
          ),
        ],
      ),
      body: Column(
        children: [16.height, _buildMessageList(), _buildChatInput()],
      ),
    );
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  Widget _buildMessageList() {
    return Expanded(
      child: Padding(
        padding: 8.paddingAll,
        child: BlocConsumer<MessageCubit, MessageState>(
          listenWhen: (previous, current) =>
              previous.messages != current.messages,
          listener: (context, state) => scrollToBottom(),
          builder: (context, state) {
            if (state.messages.isEmpty) {
              return const Center(child: Text("No message"));
            }
            return Scrollbar(
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
                itemExtent: 70,
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  final message = state.messages[index];
                  if (message.senderId != widget.friend.uid) {
                    return SendMessage(message: message.content);
                  }
                  return ReceiveMessage(message: message.content);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return ChatInput(
      onFocus: scrollToBottom,
      focusNode: _focusNode,
      onTapSend: (text) {
        sendMessage(text);
      },
    );
  }

  void sendMessage(String text) {
    final MessageEntity newMessage = MessageEntity(
      content: text,
      createdAt: DateTime.now(),
      type: MessageType.text,
      senderId: context.read<AppCubit>().state.currentUser?.uid,
    );
    _cubit.sendMessage(newMessage);
  }
}
