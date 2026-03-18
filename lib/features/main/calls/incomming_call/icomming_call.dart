import 'package:flutter/material.dart';

class IncomingCallScreen extends StatelessWidget {
  const IncomingCallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background blur / image
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black87, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 80),

              // Avatar
              CircleAvatar(
                radius: 70,
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/300",
                ),
              ),

              const SizedBox(height: 20),

              // Name
              const Text(
                "Nguyễn Văn A",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Incoming call...",
                style: TextStyle(color: Colors.grey),
              ),

              const Spacer(),

              // Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildCallButton(
                      icon: Icons.call_end,
                      color: Colors.red,
                      label: "Decline",
                    ),
                    _buildCallButton(
                      icon: Icons.call,
                      color: Colors.green,
                      label: "Accept",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCallButton({
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Column(
      children: [
        CircleAvatar(
          radius: 35,
          backgroundColor: color,
          child: Icon(icon, color: Colors.white, size: 30),
        ),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}