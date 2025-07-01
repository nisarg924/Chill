import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../themes/model/model_themes_data.dart';
import '../utils/app_themes.dart';
import '../utils/enum.dart';

class SharedPrefUtils {
  static Future<SharedPreferences> get _instance async => _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  static ModelThemesData getThemesData() {
    String? stringModel = _prefsInstance?.getString("ThemeData");
    ModelThemesData? model = stringModel != null
        ? ModelThemesData.fromMap(jsonDecode(stringModel))
        : ModelThemesData(
      fontSizeType: FontSizeType.normal.index,
      fontStyleType: FontStyleType.Gotham.index,
      themeType: AppThemesType.light.index,
    );
    return model;
  }

  static bool isLightThemes() {
    var tType = SharedPrefUtils.getThemesData().themeType ?? AppTheme.lightTheme.index;
    return tType == AppThemesType.light.index;
  }

  static Future<bool> setThemesData(ModelThemesData value) async {
    var prefs = await _instance;
    return prefs.setString("ThemeData", jsonEncode(value.toMap()));
  }

  static String getLanguageCode() {
    return _prefsInstance?.getString("languageCode") ?? "";
  }

  static Future<bool> setLanguageCode(String value) async {
    var prefs = await _instance;
    return prefs.setString("languageCode", value);
  }

  static int getLanguageId() {
    return _prefsInstance?.getInt("languageId") ?? 0;
  }

  static Future<bool> setLanguageId(int value) async {
    var prefs = await _instance;
    return prefs.setInt("languageId", value);
  }

  static bool getFirstPermissionLocation() {
    return _prefsInstance?.getBool("FirstPermissionLocation") ?? false;
  }

  static Future<bool> setFirstPermissionLocation(bool value) async {
    var prefs = await _instance;
    return prefs.setBool("FirstPermissionLocation", value);
  }

  static bool getFirstPermissionCamera() {
    return _prefsInstance?.getBool("FirstPermissionCamera") ?? false;
  }

  static Future<bool> setFirstPermissionCamera(bool value) async {
    var prefs = await _instance;
    return prefs.setBool("FirstPermissionCamera", value);
  }

  static bool getFirstPermissionContact() {
    return _prefsInstance?.getBool("FirstPermissionContact") ?? false;
  }

  static Future<bool> setFirstPermissionContact(bool value) async {
    var prefs = await _instance;
    return prefs.setBool("FirstPermissionContact", value);
  }

  static bool getFirstPermissionPhoto() {
    return _prefsInstance?.getBool("FirstPermissionPhoto") ?? false;
  }

  static Future<bool> setFirstPermissionPhoto(bool value) async {
    var prefs = await _instance;
    return prefs.setBool("FirstPermissionPhoto", value);
  }

  static bool getFirstPermissionMicroPhone() {
    return _prefsInstance?.getBool("FirstPermissionMicroPhone") ?? false;
  }

  static Future<bool> setFirstPermissionMicroPhone(bool value) async {
    var prefs = await _instance;
    return prefs.setBool("FirstPermissionMicroPhone", value);
  }

  static bool getFirstPermissionStorage() {
    return _prefsInstance?.getBool("FirstPermissionStorage") ?? false;
  }

  static Future<bool> setFirstPermissionStorage(bool value) async {
    var prefs = await _instance;
    return prefs.setBool("FirstPermissionStorage", value);
  }

  static bool getIsUserLoggedIn() {
    return _prefsInstance?.getBool("IsUserLoggedIn") ?? false;
  }

  static Future<bool> setIsUserLoggedIn(bool value) async {
    var prefs = await _instance;
    return prefs.setBool("IsUserLoggedIn", value);
  }

  static String getFcmToken() {
    return _prefsInstance?.getString("FcmToken") ?? "";
  }

  static Future<bool> setFcmToken(String value) async {
    var prefs = await _instance;
    return prefs.setString("FcmToken", value);
  }

  static String getToken() {
    return _prefsInstance?.getString("token") ?? "";
  }

  static Future<bool> setToken(String value) async {
    var prefs = await _instance;
    return prefs.setString("token", value);
  }

  static Future<void> remove() async {
    SharedPreferences.getInstance().then((SharedPreferences pref) {
      pref.clear();
    });
  }

  static getFcmTokens() {
    /* FirebaseMessaging.instance.getToken().then((token) async {
      await StartupService.setFcmToken(token!);
      logger.w("Firebase token ~~~~~~~> ${token}");
    });*/
  }

  static String getDeviceManufacture() {
    return _prefsInstance?.getString("DeviceManufacture") ?? "";
  }

  static Future<bool> setDeviceManufacture(String value) async {
    var prefs = await _instance;
    return prefs.setString("DeviceManufacture", value);
  }

  static String getDeviceOSVersion() {
    return _prefsInstance?.getString("OSVersion") ?? "";
  }

  static Future<bool> setDeviceOSVersion(String value) async {
    var prefs = await _instance;
    return prefs.setString("OSVersion", value);
  }

  static String getAppVersion() {
    return _prefsInstance?.getString("AppVersion") ?? "1.0.0";
  }

  static Future<bool> setAppVersion(String value) async {
    var prefs = await _instance;
    return prefs.setString("AppVersion", value);
  }

  static bool getUserFirstTime() {
    return _prefsInstance?.getBool("firstTimeUser") ?? true;
  }

  static Future<bool> setUserFirstTime(bool value) async {
    var prefs = await _instance;
    return prefs.setBool("firstTimeUser", value);
  }

  static String getPlatformName() {
    return Platform.isAndroid ? "android" : "iOS";
  }

  static saveDeviceModel() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setDeviceManufacture(androidInfo.manufacturer ?? "-");
      setDeviceModel(androidInfo.model ?? "-");
      setDeviceOSVersion(androidInfo.version.release ?? "-");
    } else {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setDeviceManufacture("iOS");
      setDeviceModel(iosInfo.utsname.machine ?? "-");
      setDeviceOSVersion(iosInfo.systemVersion ?? "-");
    }
  }

  static saveAppVersion() async {
    PackageInfo _packageInfo = PackageInfo(
      appName: 'Unknown',
      packageName: 'Unknown',
      version: 'Unknown',
      buildNumber: 'Unknown',
      buildSignature: 'Unknown',
    );
    var appVersion = "1.0";
    _packageInfo = await PackageInfo.fromPlatform();
    appVersion = await _packageInfo.version;
    setAppVersion(appVersion);
  }

  static String getDeviceModel() {
    return _prefsInstance?.getString("DeviceModel") ?? "";
  }

  static Future<bool> setDeviceModel(String value) async {
    var prefs = await _instance;
    return prefs.setString("DeviceModel", value);
  }

// static Future<bool> setUserModel(ModelUserResponseUser? value) async {
//   var prefs = await _instance;
//   return prefs.setString("UserModel", json.encode(value?.toJson()));
// }
//
// static ModelUserResponseUser getUserModel() {
//   ModelUserResponseUser modelUser = ModelUserResponseUser();
//   dynamic jsonString = _prefsInstance?.getString("UserModel") ?? "";
//
//   if (jsonString.isNotEmpty) {
//     modelUser = ModelUserResponseUser.fromJson(json.decode(jsonString));
//   }
//   return modelUser;
// }

// static generateFcmTokens() async {
//   await FirebaseMessaging.instance.getToken().then((token) async {
//     await SharedPrefUtils.setFcmToken(token!);
//     logger.w("Firebase token ~~~~~~~> ${token}");
//     print("Firebase token ~~~~~~~> ${token}");
//   });
// }
}
