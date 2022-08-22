import 'package:google_sign_in/google_sign_in.dart';

class LoginController {
  Future<void> googleSignIn() async {
    GoogleSignIn googleSignIn = GoogleSignIn(scopes: [
      "email",
    ]);
    try {
      final response = await googleSignIn.signIn();
      print(response);
    } catch (error) {
      print(error);
    }
  }
}
