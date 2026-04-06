import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chatbox/data/models/entity/call_entity.dart';
import 'package:chatbox/features/main/calls/calling/calling_screen_cubit.dart';
import 'package:chatbox/features/main/calls/calls_cubit.dart';
import 'package:chatbox/features/main/calls/calls_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'calling_screen_state.dart';

class CallingScreen extends StatelessWidget {
  final CallEntity? call;

  const CallingScreen({super.key, this.call});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CallingScreenCubit>(
      create: (context) => CallingScreenCubit(
        callsCubit: context.read(),
        agoraService: context.read<CallsCubit>().agora,
      ),
      child: CallingScreenChild(call: call),
    );
  }
}

class CallingScreenChild extends StatefulWidget {
  final CallEntity? call;

  const CallingScreenChild({super.key, this.call});

  @override
  State<CallingScreenChild> createState() => _CallingScreenChildState();
}

class _CallingScreenChildState extends State<CallingScreenChild> {
  late final CallingScreenCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read();
  }

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
      child: Scaffold(backgroundColor: Colors.black, body: _buildBody()),
    );
  }

  Widget _buildBody() {
    return BlocBuilder<CallingScreenCubit, CallingScreenState>(
      builder: (context, state) {
        final agora = context.read<CallsCubit>().agora;

        return Stack(
          children: [
            /// REMOTE VIDEO
            if (state.remoteUid != null)
              AgoraVideoView(
                controller: VideoViewController.remote(
                  rtcEngine: agora.engine,
                  canvas: VideoCanvas(uid: state.remoteUid),
                  connection: RtcConnection(channelId: widget.call!.channelId),
                ),
              ),

            /// LOCAL VIDEO
            if (widget.call?.isVideo == true)
              Positioned(
                top: 100,
                right: 20,
                width: 120,
                height: 160,
                child: AgoraVideoView(
                  controller: VideoViewController(
                    rtcEngine: agora.engine,
                    canvas: const VideoCanvas(uid: 0),
                  ),
                ),
              ),

            _buildOverlayPage(),
          ],
        );
      },
    );
  }

  Widget _buildOverlayPage() {
    return Column(
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
    return GestureDetector(
      onTap: () {
        _cubit.rejectCall();
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.red,
            child: const Icon(Icons.call_end, color: Colors.white),
          ),
          const SizedBox(height: 10),
          const Text("End", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}
