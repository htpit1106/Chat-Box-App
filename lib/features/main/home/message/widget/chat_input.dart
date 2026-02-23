import 'package:chatbox/core/extensions/num_extension.dart';
import 'package:flutter/material.dart';

class ChatInput extends StatefulWidget {
  final VoidCallback? onFocus;
  final FocusNode focusNode;
  // onTapSend tra get text trong controller
  final Function(String text) onTapSend;
  const ChatInput({
    super.key,
    this.onFocus,
    required this.focusNode,
    required this.onTapSend,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();

  bool _hasText = false;

  @override
  void initState() {
    super.initState();

    widget.focusNode.addListener(() {
      if (widget.focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 50), () {
          widget.onFocus?.call();
        });
      }
    });

    _controller.addListener(() {
      final hasText = _controller.text.trim().isNotEmpty;
      if (hasText != _hasText) {
        setState(() {
          _hasText = hasText;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _controller,
                focusNode: widget.focusNode,
                decoration: const InputDecoration(
                  hintText: 'Write your message',
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: 1,
              ),
            ),
          ),
          8.width,
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 100),
            child: _hasText
                ? GestureDetector(
                    onTap: () {
                      final text = _controller.text.trim();
                      if (text.isEmpty) return;
                      widget.onTapSend(text);
                      _controller.clear();
                    },
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFF0BA37F),
                      child: const Icon(Icons.send, color: Colors.white),
                    ),
                  )
                : Row(
                    spacing: 8,
                    children: [
                      const Icon(Icons.camera_alt),
                      const Icon(Icons.mic),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
