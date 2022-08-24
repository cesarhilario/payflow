import 'package:flutter/material.dart';

import '../../shared/auth/auth_controller.dart';
import '../../shared/routes/routes_controller.dart';

class SplashController {
  static init(BuildContext context) {
    final authController = AuthController();
    final routerController = RoutesController();

    routerController.setContext(context);

    authController.hasUserOnSharedPreferences().then((isAuthenticated) => {
          if (isAuthenticated)
            {routerController.goToHomepage()}
          else
            {routerController.goToLoginPage()}
        });
  }
}
