import 'package:chatbox/core/base/base_navigator.dart';
import 'package:chatbox/data/models/entity/call_entity.dart';
import 'package:chatbox/navigation/app_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class CallsNavigator extends BaseNavigator {
  CallsNavigator({required super.context});

  void goToCallingScreen(BuildContext context) {
    context.pushNamed(AppRouter.callingRouteName);
  }

  void showIncomingCall(CallEntity call) {
    AppRouter.router.pushNamed(AppRouter.incomingCallRouteName, extra: call);
  }
}
