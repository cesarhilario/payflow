import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:payflow/shared/routes/routes_controller.dart';
import 'package:payflow/shared/auth/auth_controller.dart';

class LoginController {
  final authController = AuthController();

  final routesController = RoutesController();

  Future<void> googleSignIn(BuildContext context) async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      "email",
    ]);

    routesController.setContext(context);

    try {
      final response = await googleSignIn.signIn();
      authController.setUser(response);
      routesController.goToHomepage();
    } catch (error) {
      routesController.goToLoginPage();
    }
  }
}
