import 'package:chatbox/data/models/entity/call_entity.dart';
import 'package:chatbox/features/main/calls/calls_cubit.dart';
import 'package:chatbox/features/main/calls/calls_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CallingScreen extends StatelessWidget {
  final CallEntity? call;

  const CallingScreen({super.key, this.call});

  @override
  Widget build(BuildContext context) {
    return CallingScreenChild(call: call);
  }
}

class CallingScreenChild extends StatefulWidget {
  final CallEntity? call;

  const CallingScreenChild({super.key, this.call});

  @override
  State<CallingScreenChild> createState() => _CallingScreenChildState();
}

class _CallingScreenChildState extends State<CallingScreenChild> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CallsCubit, CallsState>(
      listener: (_, state) {
        if (state.status == CallStatus.ended) {
          if (context.canPop()) {
            context.pop();
          }
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            const SizedBox(height: 100),

            // Avatar
            CircleAvatar(
              radius: 70,
              backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
            ),

            const SizedBox(height: 20),

            const Text(
              "Nguyễn Văn A",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text("Calling...", style: TextStyle(color: Colors.grey)),

            const Spacer(),

            // Control buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIcon(Icons.mic, "Mute"),
                _buildIcon(Icons.volume_up, "Speaker"),
                _buildEndCall(),
              ],
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(IconData icon, String label) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white24,
          child: Icon(icon, color: Colors.white),
        ),
        const SizedBox(height: 10),
        Text(label, style: const TextStyle(color: Colors.white)),
      ],
    );
  }

  Widget _buildEndCall() {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.red,
          child: const Icon(Icons.call_end, color: Colors.white),
        ),
        const SizedBox(height: 10),
        const Text("End", style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
