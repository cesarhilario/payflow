import 'package:flutter/material.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/social_login/social_login_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final controller = LoginController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: AppColors.primary,
      /* Set your status bar color here */
      child: SafeArea(
        bottom: false,
        child: Container(
          color: AppColors.background,
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Container(
                width: size.width,
                height: size.height * 0.36,
                color: AppColors.primary,
              ),
              Positioned(
                  top: size.height * 0.03,
                  left: 0,
                  right: 0,
                  child: ShaderMask(
                    shaderCallback: (rect) {
                      return const LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [Colors.black, Colors.transparent])
                          .createShader(
                              Rect.fromLTRB(0, 150, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: Image.asset(
                      AppImages.person,
                      width: size.width * 0.58,
                      height: size.height * 0.48,
                    ),
                  )),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        AppImages.logomini,
                        width: size.width * 0.3,
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 70, right: 70, top: 30),
                        child: Text(
                          "Organize seus boletos em um só lugar",
                          textAlign: TextAlign.center,
                          style: AppTextStyles.titleHome,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 40, right: 40, top: 40),
                        child: SocialLoginButton(
                          onTap: controller.googleSignIn,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
