import 'package:flutter/material.dart';

class RoutesController {
  late BuildContext mContext;
  BuildContext get context => mContext;
  set context(BuildContext context) => mContext = context;

  void setContext(BuildContext context) {
    mContext = context;
  }

  void goToHomepage() {
    Navigator.pushReplacementNamed(mContext, "/home");
  }

  void goToLoginPage() {
    Navigator.pushReplacementNamed(mContext, "/login");
  }

  void goToBarcodeScannerPage() {
    Navigator.pushNamed(mContext, "/barcode_scanner");
  }

  void goToInsertBilletPage() {
    Navigator.pushNamed(mContext, "/insert_billet");
  }
}
