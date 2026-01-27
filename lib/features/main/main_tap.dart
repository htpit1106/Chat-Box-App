enum MainTap { message, calls, contacts, settings }

// extension
extension MainTapExt on MainTap {
  String get iconPath {
    switch (this) {
      case MainTap.message:
        return 'assets/icons/message.png';
      case MainTap.calls:
        return 'assets/icons/calls.png';
      case MainTap.contacts:
        return 'assets/icons/contacts.png';
      case MainTap.settings:
        return 'assets/icons/settings.png';
    }
  }
  // get Page

}
