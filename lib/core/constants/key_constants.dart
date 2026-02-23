class KeyConstants {
  KeyConstants._();

  // Keys for SharedPreferences or Secure Storage
  static const String prefsKeyIsFirstRun = 'prefs_is_first_run';
  static const String prefsKeyAuthToken = 'prefs_auth_token';
  static const String prefsKeyThemeMode = 'prefs_theme_mode';

  // collection firebase
  static const String collectionUsers = 'users';
  static const String collectionConversations = 'conversations';
  static const String collectionMessages = 'messages';
}
