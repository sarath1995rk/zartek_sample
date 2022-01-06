import 'package:shared_preferences/shared_preferences.dart';

const kUserName = "name";

const kUserId = "user_id";

class SharedPreferencesRepo {
  static SharedPreferences? _prefs;
  static SharedPreferencesRepo? _instance;

  SharedPreferencesRepo._(SharedPreferences prefs) {
    _prefs = prefs;
  }

  static SharedPreferencesRepo get instance => _instance!;

  static Future<void> initialize() async {
    if (_instance == null)
      _instance =
          SharedPreferencesRepo._(await SharedPreferences.getInstance());
  }

  void signIn(String name, String id) {
    _prefs!.setString(kUserName, name);
    _prefs!.setString(kUserId, id);
  }

  void signOut() {
    _prefs!.clear();
  }

  String get nameOfUser => _prefs!.getString(kUserName)!;

  String get idOfUser => _prefs!.getString(kUserId)!;
}
