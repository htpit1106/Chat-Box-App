import 'package:flutter/material.dart';

class BaseNavigator {
  final BuildContext context;
  // late FlushbarNavigator flushbarNavigator;
  // late AppDialog appDialog;

  /// Creates a BaseNavigator. Requires the [context] from which navigation
  /// will be initiated.
  BaseNavigator({required this.context}) {
    // // flushbarNavigator = FlushbarNavigator(context);
    // appDialog = AppDialog(context);
  }
}