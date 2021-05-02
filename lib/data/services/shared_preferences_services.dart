import 'package:packet_tea/data/services/secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceService {
  static const _uniquePrefix = 'com.packettea.sharedpreferences.key';
  static const _isLoggedIn = "${_uniquePrefix}_isLoggedIn";
  static const _estateID = "${_uniquePrefix}_estateID";
  static const _estateName = "${_uniquePrefix}_estateName";
  static const _userName = "${_uniquePrefix}_userName";

  const SharedPreferenceService();

  Future<void> ensureInitialized() async {
    await setLogin();
  }

  /// Setters and Getters
  Future<void> setLogin() async {
    var sp = await SharedPreferences.getInstance();
    final SecureStorageService _secureStorage = SecureStorageService();
    if (await _secureStorage.readSecureData("AccessToken") != null) {
      sp.setBool(_isLoggedIn, true);
    } else {
      sp.setBool(_isLoggedIn, false);
    }
  }

  Future<bool> isLoggedIn() async {
    final SecureStorageService _secureStorage = SecureStorageService();
    if (await _secureStorage.readSecureData("AccessToken") != null &&
        await getEstateID() != null &&
        await getEstateName() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> setEstateID(String id) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(_estateID, id);
  }

  Future<String> getEstateID() async {
    var sp = await SharedPreferences.getInstance();
    var provider = sp.getString(_estateID);
    return Future.value(provider);
  }

  Future<void> setEstateName(String name) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(_estateName, name);
  }

  Future<String> getEstateName() async {
    var sp = await SharedPreferences.getInstance();
    var provider = sp.getString(_estateName);
    return Future.value(provider);
  }

  Future<void> setUserName(String name) async {
    var sp = await SharedPreferences.getInstance();
    sp.setString(_userName, name);
  }

  Future<String> getUserName() async {
    var sp = await SharedPreferences.getInstance();
    var provider = sp.getString(_userName);
    return Future.value(provider);
  }
}
