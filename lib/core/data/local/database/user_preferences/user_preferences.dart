import 'package:hive/hive.dart';
import '../model/current_user/user.dart';
import 'user_preferences_keys.dart';

class UserPreferences {
  static const _preferencesBox = '_preferencesBox';
  Box<Object>? _box;

  static init() async {
    await Hive.openBox<Object>(_preferencesBox);
  }

  UserPreferences._() {
    _box = Hive.box<Object>(_preferencesBox);
  }

  /// This doesn't have to be a singleton.
  /// We just want to make sure that the box is open, before we start getting/setting objects on it
  static UserPreferences getInstance() {
    return UserPreferences._();
  }

  /// Saving user sign in data
  Future<void>? putCurrentUser(User currentUser) {
    return _box?.put(UserPreferencesKeys.currentUser, currentUser);
  }

  /// Retrieve user sign in data
  User? getCurrentUser() {
    return _box?.get(UserPreferencesKeys.currentUser) as User?;
  }

  Future<void>? putXAuthToken(String value) {
    return _box?.put(UserPreferencesKeys.xAuthToken, value);
  }

  String? getXAuthToken() {
    return _box?.get(UserPreferencesKeys.xAuthToken) as String?;
  }

  void clearUserPreferences() {
    _box?.clear();
  }
}
