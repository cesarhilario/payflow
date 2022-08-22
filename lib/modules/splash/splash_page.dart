import 'package:flutter/material.dart';
import 'package:payflow/modules/splash/splash_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    SplashController.init(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(children: [
        Center(
            child: Image.asset(
          AppImages.union,
          width: size.width * 0.8,
        )),
        Center(
            child: Image.asset(
          AppImages.logofull,
          width: size.width * 0.6,
        )),
      ]),
    );
  }
}
