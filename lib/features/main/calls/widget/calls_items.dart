import 'package:flutter/material.dart';

class CallItem extends StatelessWidget {
  final String name;
  final String time;
  final String avatarUrl;
  final VoidCallback? onTapCall;
  final VoidCallback? onTapVideoCall;

  const CallItem({
    super.key,
    required this.name,
    required this.time,
    required this.avatarUrl,
    this.onTapCall,
    this.onTapVideoCall,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          // Avatar
          if (avatarUrl.isNotEmpty)
            CircleAvatar(radius: 24, backgroundImage: NetworkImage(avatarUrl)),

          const SizedBox(width: 12),

          // Name + time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   name,
                //   maxLines: 1,
                //   overflow: TextOverflow.ellipsis,
                //   style: const TextStyle(
                //     fontSize: 16,
                //     fontWeight: FontWeight.w600,
                //   ),
                // ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.call_made, size: 16, color: Colors.purple),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Action icons
        ],
      ),
    );
  }
}
