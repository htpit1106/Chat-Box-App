import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:flutter/material.dart';

class ReceiveMessage extends StatelessWidget {
  final String? avatar;
  final String message;
  final String time;

  const ReceiveMessage({
    super.key,
    this.avatar,
    this.message = "Have a great working week!!",
    this.time = "12:00",
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: avatar == null
              ? AppAssetImage(path: AssetConstants.onboardingBg, size: Size(40, 40))
              : Image.network(avatar!),
        ),
        const SizedBox(width: 8),
        Container(
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: const Text('Have a great working week!!'),
        ),
      ],
    );
  }
}
