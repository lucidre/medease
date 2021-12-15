import 'package:shared_preferences/shared_preferences.dart';

class UserPref {
  static SharedPreferences? _preference;

  static Future init() async =>
      _preference = await SharedPreferences.getInstance();
  static const onBoardingStatusKey = 'onBoardingStatus';
  static const _userKey = 'userKey';
  static const _firstNameKey = 'firstNameKey';
  static const _lastNameKey = 'lastNameKey';
  static const _registrationKey = 'registrationKey';

  static Future setOnBoardingStatus({required bool status}) async {
    await _preference?.setBool(onBoardingStatusKey, status);
  }

  static Future setUserLoggedInStatus(
      {required String userId,
      required String firstName,
      required lastName,
      required registrationNo}) async {
    await _preference?.setString(_userKey, userId);
    await _preference?.setString(_firstNameKey, firstName);
    await _preference?.setString(_lastNameKey, lastName);
    await _preference?.setString(_registrationKey, registrationNo);
  }

  static bool get onBoardingStatus =>
      _preference?.getBool(onBoardingStatusKey) ?? false;

  static String get userFirstName =>
      _preference?.getString(_firstNameKey) ?? '';

  static String get userLastName => _preference?.getString(_lastNameKey) ?? '';

  static String get userKey => _preference?.getString(_userKey) ?? '';

  static String get userRegistration =>
      _preference?.getString(_registrationKey) ?? '';

  static String get userFullName => userFirstName + " " + userLastName;

  static bool get isUserLoggedIn =>
      _preference?.getString(_userKey) != null &&
      _preference?.getString(_userKey) != '';
}
