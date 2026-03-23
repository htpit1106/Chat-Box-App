import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:chatbox/core/configs/app_configs.dart';

class AgoraService {
  late RtcEngine engine;
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(appId: AppConfigs.appIdAgora));
    await engine.enableVideo();
    _initialized = true;
  }

  Future<void> join(String channelId) async {
    await init();
    await engine.startPreview();
    await engine.joinChannel(
      token: "",
      channelId: channelId,
      uid: DateTime.now().millisecondsSinceEpoch % 100000,
      options: const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        publishCameraTrack: true,
        publishMicrophoneTrack: true,
        autoSubscribeAudio: true,
        autoSubscribeVideo: true,
      ),
    );
  }

  Future<void> leave() async {
    await engine.leaveChannel();
  }

  void dispose() {
    engine.release();
  }
}
