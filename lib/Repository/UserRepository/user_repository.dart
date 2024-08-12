import 'package:instagram_clone/Model/User/user.dart';

abstract class UserRepository {
  Future<User> fetchUser({required String uid});
}