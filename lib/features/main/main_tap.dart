import 'package:chatbox/core/constants/asset_constants.dart';
import 'package:flutter/material.dart';

import 'calls/calls_page.dart';
import 'contacts/contacts_page.dart';
import 'home/home_page.dart';
import 'settings/settings_page.dart';

enum MainTap { message, calls, contacts, settings }

// extension
extension MainTapExt on MainTap {
  String get iconPath {
    switch (this) {
      case MainTap.message:
        return AssetConstants.message;
      case MainTap.calls:
        return AssetConstants.calls;
      case MainTap.contacts:
        return AssetConstants.contacts;
      case MainTap.settings:
        return AssetConstants.settings;
    }
  }

  // get Page
  Widget get page {
    switch (this) {
      case MainTap.message:
        return const HomePage();
      case MainTap.calls:
        return const CallsPage();
      case MainTap.contacts:
        return const ContactsPage();
      case MainTap.settings:
        return const SettingsPage();
    }
  }
}
