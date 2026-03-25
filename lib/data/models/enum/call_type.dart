import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:chatbox/data/models/entity/call_entity.dart';

enum CallType { incoming, missed, outgoing }

extension CallTypeExt on CallType {
  String get icon {
    switch (this) {
      case CallType.incoming:
        return AssetConstants.incomingCall;
      case CallType.missed:
        return AssetConstants.missedCall;
      case CallType.outgoing:
        return AssetConstants.outgoingCall;
    }
  }

  static CallType callTypeString(String? type) {
    switch (type) {
      case "incoming":
        return CallType.incoming;
      case "rejected":
        return CallType.missed;
      case "outgoing":
        return CallType.outgoing;
      default:
        return CallType.outgoing;
    }
  }

  static String avatarTypeString(String? type, CallEntity call) {
    switch (type) {
      case "incoming":
        return call.callerAvatar ?? "";
      case "rejected":
        return call.receiverAvatar ?? "";
      case "outgoing":
        return call.receiverAvatar ?? "";
      default:
        return "";
    }
  }
}
