import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram_clone/Core/Auth/Service/auth_error.dart';
import 'package:instagram_clone/Core/Auth/Service/auth_service.dart';

class RegistrationViewModel {
  // AuthServiceのシングルトンインスタンスを取得
  final authService = AuthService.instance;

  Future<String?> signUp(
      {required String email,
      required String password,
      required String username}) async {
    try {
      // シングルトンインスタンスからlogin関数を呼ぶ
      await authService.signUp(
          email: email, password: password, username: username);
    } on FirebaseAuthException catch (e) {
      return getSignUpErrorMessage(e.code);
    }
  }
}
