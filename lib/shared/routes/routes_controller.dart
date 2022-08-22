import 'package:flutter/material.dart';

class RoutesController {
  late BuildContext _context;

  get context => _context;

  void goToHomepage() {
    Navigator.pushReplacementNamed(_context, "/home");
  }

  void goToLoginPage() {
    Navigator.pushReplacementNamed(_context, "/login");
  }

  void setContext(BuildContext context) {
    _context = context;
  }
}
