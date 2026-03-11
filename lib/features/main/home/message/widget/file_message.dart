import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/core/widgets/image/app_assets_image.dart';
import 'package:flutter/material.dart';

class FileMessage extends StatelessWidget {
  final String time;
  final bool isSend;
  final String? avatar;
  final String fileName;
  final String fileSize;

  const FileMessage({
    super.key,
    String? time,
    this.isSend = false,
    this.avatar,
    this.fileName = "file.pdf",
    this.fileSize = "0KB",
  }) : time = time ?? "12:00";

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isSend
          ? MainAxisAlignment.end
          : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isSend)
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: avatar == null
                ? AppAssetImage(
                    path: AssetConstants.onboardingBg,
                    size: const Size(40, 40),
                  )
                : Image.network(
                    avatar!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
          ),

        if (!isSend) const SizedBox(width: 6),

        Container(
          constraints: const BoxConstraints(maxWidth: 250),
          margin: const EdgeInsets.only(bottom: 6),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: isSend
                ? const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.file_present_outlined),
              const SizedBox(width: 8),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(fileSize, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
