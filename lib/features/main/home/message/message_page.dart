import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:chatbox/core/widgets/app_bar/app_bar_widget.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:chatbox/data/models/entity/user_profile/user_entity.dart';
import 'package:chatbox/data/models/enum/input_mode.dart';
import 'package:chatbox/data/models/enum/message_type.dart';
import 'package:chatbox/features/main/calls/calls_cubit.dart';
import 'package:chatbox/features/main/home/message/message_cubit.dart';
import 'package:chatbox/features/main/home/message/widget/chat_input.dart';
import 'package:chatbox/features/main/home/message/widget/media_picker_bottom_sheet_page.dart';
import 'package:chatbox/features/main/home/widget/avatar_with_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'message_state.dart';

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
        mediaRepos: context.read(),
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
  late final CallsCubit callCubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<MessageCubit>();
    _cubit.init(widget.friend.uid.toString());
    callCubit = context.read<CallsCubit>();
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
            Expanded(child: Text(widget.friend.name ?? "unknow")),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              callCubit.startCall(receiver: widget.friend, isVideo: false);
            },
            icon: AppAssetImage(path: AssetConstants.call),
          ),
          IconButton(
            onPressed: () {},
            icon: AppAssetImage(path: AssetConstants.video),
          ),
        ],
      ),
      body: Column(
        children: [
          16.height,
          _buildMessageList(),
          _buildChatInput(),
          BlocBuilder<MessageCubit, MessageState>(
            buildWhen: (previous, current) =>
                previous.inputMode != current.inputMode ||
                previous.selectedMedias != current.selectedMedias,
            builder: (context, state) {
              return state.inputMode == InputMode.media
                  ? SizedBox(height: 320, child: _buildListThumbnailImg())
                  : const SizedBox();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildListThumbnailImg() {
    return BlocBuilder<MessageCubit, MessageState>(
      buildWhen: (previous, current) =>
          previous.selectedMedias != current.selectedMedias ||
          previous.medias != current.medias,
      builder: (context, state) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
          ),
          itemCount: state.medias.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return IconButton(
                onPressed: () {},
                icon: const Icon(Icons.camera_alt),
              );
            }
            final media = state.medias[index - 1];
            final isSelected = _cubit.isSelected(media);
            return MediaPickerBottomSheet(
              media: media,
              isSelected: isSelected,
              onTap: () => _cubit.toggleSelect(media),
            );
          },
        );
      },
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
                itemCount: state.messages.length,
                itemBuilder: (context, index) {
                  final message = state.messages[index];
                  final isSend =
                      message.senderId ==
                      _cubit.appCubit.state.currentUser?.uid;
                  return message.type?.buildMessage(
                    message: message,
                    isSend: isSend,
                    avatar: widget.friend.avatarUrl,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return BlocBuilder<MessageCubit, MessageState>(
      builder: (context, state) {
        return ChatInput(
          onFocus: scrollToBottom,
          focusNode: _focusNode,
          onTap: () {
            _cubit.hideInput();
            _cubit.showKeyboard();
          },
          onTapSend: (text) {
            if (text.isNotEmpty) {
              _cubit.sendMessage(text: text, type: MessageType.text);
            } else if (_cubit.hasSelected()) {
              _cubit.uploadSelectedMedias();
            }
          },
          onUploadFile: () {
            _cubit.onUploadFilesTap();
          },
          onTapCamera: () async {
            _focusNode.unfocus();
            _cubit.showMedia();
          },
          canSend: _cubit.hasSelected(),
        );
      },
    );
  }
}
