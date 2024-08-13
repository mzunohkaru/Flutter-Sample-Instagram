import 'package:firebase_auth/firebase_auth.dart';

import '../../../Utils/constant.dart';
import 'auth_error.dart';

class AuthService {
  AuthService._privateConstructor();

  static final AuthService instance = AuthService._privateConstructor();

  factory AuthService() {
    return instance;
  }

  Future<String?> login(
      {required String email, required String password}) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print("ログイン成功");
  }

  Future<String?> signUp(
      {required String email,
      required String password,
      required String username}) async {
    final userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await _saveUserToFirestore(userCredential.user!.uid, username, email);
    print("サインアップ成功");
  }

  Future _saveUserToFirestore(
      String userId, String username, String email) async {
    try {
      await UserCollections.doc(userId).set({
        'userId': userId,
        'username': username,
        'email': email,
        'followers': 0,
        'following': 0,
        'likes': 0,
      });
    } on FirebaseAuthException catch (e) {
      print(getFirestoreErrorMessage(e.code));
    }
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      print("サインアウト成功");
    } on FirebaseAuthException catch (e) {
      print("サインアウト失敗: $e");
    }
  }
}
