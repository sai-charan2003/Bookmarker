import 'package:shared_preferences/shared_preferences.dart';

class Sharedprefhelper {
  static SharedPreferences? _preferences;
  static const _lastUpdated = "last_updated";
  static const _hasDataToSync = "has_data_to_sync";
  static const _inAppBrowser = "in_app_browser";
  static const _isMiniCard = "is_mini_card";
  static Future<void> init() async{
    _preferences = await SharedPreferences.getInstance();

  }
  static Future<void> setLastSyncedTime(String time) async {
    await _preferences?.setString(_lastUpdated, time);
  }
  static Future<void> setHasDataToSync(bool hasData) async {
    await _preferences?.setBool(_hasDataToSync, hasData);
  }
  static Future<void> setIsInAppBrowser(bool hasData) async {
    await _preferences?.setBool(_inAppBrowser, hasData);
  }
  static Future<void> setIsMiniCard(bool hasData) async {
    await _preferences?.setBool(_isMiniCard, hasData);
  }
  static String? getLastSyncedTime() {
    return _preferences?.getString(_lastUpdated);
  }
  static bool? getHasDataToSync(){
    return _preferences?.getBool(_hasDataToSync);
  }
  static bool? getIsInAppBrowser(){
    return _preferences?.getBool(_inAppBrowser);
  }
  static bool? getIsInMiniCard(){
    return _preferences?.getBool(_isMiniCard);
  }
}
