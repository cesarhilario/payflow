class AuthController {
  bool _isAuthenticated = false;
  dynamic _user;

  get user => _user;
  get isAuthenticated => _isAuthenticated;

  void setUser(var user) {
    if (user != null) {
      _user = user;
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
    }
  }
}
