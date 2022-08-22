import 'package:flutter/material.dart';
import 'package:payflow/modules/home/home_page.dart';
import 'package:payflow/modules/login/login_page.dart';

class RoutesController {
  late BuildContext _context;

  get context => _context;

  void goToHomepage() {
    Navigator.push(
        _context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  void goToLoginPage() {
    Navigator.push(
        _context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  void setContext(BuildContext context) {
    _context = context;
  }
}
