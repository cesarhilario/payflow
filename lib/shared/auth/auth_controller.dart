import 'package:payflow/shared/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController {
  bool _isAuthenticated = false;
  UserModel? _user;

  UserModel get user => _user!;
  get isAuthenticated => _isAuthenticated;

  void setUser(UserModel? user) {
    if (user != null) {
      _user = user;
      saveUserOnSharedPreferences(user);
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }
  }

  Future<void> saveUserOnSharedPreferences(UserModel user) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString("user", user.toJson());
  }

  Future<bool> hasUserOnSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();

    // TODO: REMOVE THIS SHIT QUICKLY
    await Future.delayed(const Duration(milliseconds: 700));

    if (sharedPreferences.containsKey("user")) {
      final json = sharedPreferences.getString("user");
      if (json != null) {
        setUser(UserModel.fromJson(json));
        return isAuthenticated;
      }
    } else {
      setUser(null);
      return false;
    }
    return false;
  }
}
