import 'dart:convert';

import 'package:chatbox/core/constants/key_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SecureStorageHelper {

  final FlutterSecureStorage _storage;

  SecureStorageHelper._(this._storage);

  static final SecureStorageHelper _instance =
  SecureStorageHelper._(const FlutterSecureStorage());

  static SecureStorageHelper get instance => _instance;

  static Future<bool> get isFirstRun async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun = prefs.getBool(KeyConstants.prefsKeyIsFirstRun) ?? true;
    await prefs.setBool(KeyConstants.prefsKeyIsFirstRun, false);
    return isFirstRun;
  }

  static Future<void> ensureFirstRunClearsSecureStorage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isFirstRun = prefs.getBool(KeyConstants.prefsKeyIsFirstRun) ?? true;

      if (isFirstRun) {
        // await _instance._storage.deleteAll();
        // await prefs.setBool(_firstRunKey, false);
      }
    } catch (_) {}
  }

}
