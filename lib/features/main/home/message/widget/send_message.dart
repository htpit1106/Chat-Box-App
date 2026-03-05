import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:flutter/material.dart';

class SendMessage extends StatelessWidget {
  final String? message;
  final String time;
  final bool isSend;
  final String? avatar;

  const SendMessage({
    super.key,
    this.message = "You did your job well!",
    String? time,
    this.isSend = false,
    this.avatar,
  }) : time = time ?? "12:00";

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSend ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isSend)
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: avatar == null
                  ? AppAssetImage(
                      path: AssetConstants.onboardingBg,
                      size: Size(40, 40),
                    )
                  : Image.network(avatar!),
            ),
          const SizedBox(width: 6),
          Container(
            margin: const EdgeInsets.only(bottom: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSend ? const Color(0xFF0BA37F) : Colors.grey.shade100,
              borderRadius: isSend
                  ? BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
            ),
            child: Text(
              message ?? '',
              style: isSend
                  ? TextStyle(color: Colors.white)
                  : TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}
