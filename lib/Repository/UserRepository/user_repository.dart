import '../../Model/Entity/User/user.dart';

abstract class UserRepository {
  Future<User> fetchUser({required String uid});
  
  Future<List<User>> getAllUsers();

  Future<void> followUser({required String currentUid, required String uid});
  Future<void> unfollowUser({required String currentUid, required String uid});
}