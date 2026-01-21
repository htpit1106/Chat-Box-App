import 'package:chatbox/core/constants/key_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SecureStorageHelper {

  // fluttersecurestorage operate like api of keychain and android keystorage
  final FlutterSecureStorage _storage;

  SecureStorageHelper._(this._storage);


  static final SecureStorageHelper _instance =
  SecureStorageHelper._(const FlutterSecureStorage());

  static SecureStorageHelper get instance => _instance;
  static Future<bool> get isFirstRun async {
    final prefs = await SharedPreferences.getInstance();
    final isFirstRun =
        prefs.getBool(KeyConstants.prefsKeyIsFirstRun) ?? true;

    if (isFirstRun) {
      await _instance._storage.deleteAll();
      await prefs.setBool(KeyConstants.prefsKeyIsFirstRun, false);
    }

    return isFirstRun;
  }

}
