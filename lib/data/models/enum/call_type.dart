import 'package:chatbox/core/constants/asset_constants.dart';

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
}
