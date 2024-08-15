import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/Core/Auth/Service/auth_error.dart';
import 'package:instagram_clone/Utils/constant.dart';

class LoginViewModel {
  Future<String?> login(
      {required String email, required String password}) async {
    try {
      await authService.login(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      return getLoginErrorMessage(e.code);
    }
    return null;
  }
}
