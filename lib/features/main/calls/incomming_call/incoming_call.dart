import 'package:chatbox/core/widgets/image/app_cache_image.dart';
import 'package:chatbox/data/models/entity/call_entity.dart';
import 'package:chatbox/features/main/calls/calls_cubit.dart';
import 'package:chatbox/features/main/calls/calls_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'incoming_call_cubit.dart';

class IncomingCallScreen extends StatelessWidget {
  final CallEntity? call;

  const IncomingCallScreen({super.key, this.call});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<IncomingCallCubit>(
      create: (context) => IncomingCallCubit(callsCubit: context.read()),
      child: IncomingCallScreenChild(call: call),
    );
  }
}

class IncomingCallScreenChild extends StatefulWidget {
  final CallEntity? call;

  const IncomingCallScreenChild({super.key, this.call});

  @override
  State<IncomingCallScreenChild> createState() =>
      _IncomingCallScreenChildState();
}

class _IncomingCallScreenChildState extends State<IncomingCallScreenChild> {
  late final IncomingCallCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CallsCubit, CallsState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (_, state) {
        if (state.status == CallStatus.ended) {
          if (context.canPop()) {
            context.pop();
          }
        }
      },
      child: Scaffold(backgroundColor: Colors.black, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    final CallEntity? caller = widget.call;
    return Stack(
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
            AppCacheImage(
              path: caller?.callerAvatar ?? "",
              size: Size(100, 100),
            ),

            const SizedBox(height: 20),

            // Name
            Text(
              caller?.callerName ?? "unknow user",
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
                    onPressed: () {
                      _cubit.rejectCall();
                    },
                  ),
                  _buildCallButton(
                    icon: Icons.call,
                    color: Colors.green,
                    label: "Accept",
                    onPressed: () => _cubit.acceptCall(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ],
    );
  }

  Widget _buildCallButton({
    required IconData icon,
    required Color color,
    required String label,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: color,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 10),
          Text(label, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
