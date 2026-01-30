import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:chatbox/features/main/home/message/message_cubit.dart';
import 'package:chatbox/features/main/home/widget/avater_with_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/date_divider.dart';
import 'widget/receive_message.dart';
import 'widget/send_message.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => MessageCubit(), child: MessagePageChild());
  }
}

class MessagePageChild extends StatefulWidget {
  const MessagePageChild({super.key});

  @override
  State<MessagePageChild> createState() => _MessagePageChildState();
}

class _MessagePageChildState extends State<MessagePageChild> {
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(spacing: 10, children: [AvatarWithStatus(), Text("Alex")]),
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
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              itemExtent: 90,
              children: [
                DateDivider(),
                SendMessage(),
                ReceiveMessage(),
                SendMessage(),
                ReceiveMessage(),
                DateDivider(),
                SendMessage(),
                ReceiveMessage(),
                SendMessage(),
                ReceiveMessage(),
              ],
            ),
          ),

          // when keyboard push up or no
          MediaQuery.of(context).viewInsets.bottom > 0 ? chatInputOpened() : chatInputClosed(),
        ],
      ),
    );
  }

  Widget chatInputClosed() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(Icons.attach_file),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: 'Write your message',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 1,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.camera_alt),
          const SizedBox(width: 8),
          const Icon(Icons.mic),
        ],
      ),
    );
  }

  Widget chatInputOpened() {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          const Icon(Icons.attach_file),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  hintText: 'Write your message',
                  border: InputBorder.none,

                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                minLines: 1,
              ),
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(_focusNode);
            },
            child: CircleAvatar(
              backgroundColor: const Color(0xFF0BA37F),
              child: const Icon(Icons.send, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
