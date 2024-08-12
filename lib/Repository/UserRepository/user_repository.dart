import 'package:instagram_clone/Model/Entity/User/user.dart';

abstract class UserRepository {
  Future<User> fetchUser({required String uid});
  
  Future<List<User>> getAllUsers();
}