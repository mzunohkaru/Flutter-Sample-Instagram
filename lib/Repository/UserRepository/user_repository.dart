import '../../Model/Entity/User/user.dart';

abstract class UserRepository {
  Future<User> fetchUser({required String uid});

  Future<List<User>> getAllUsers();

  Future<bool> checkIfUserFollowed(
      {required String currentUid, required String uid});
  Future<void> followUser({required String currentUid, required String uid});
  Future<void> unfollowUser({required String currentUid, required String uid});

  Future<bool> checkIfPostLiked(
      {required String currentUserId, required String postId});

  Future<void> updateUser({required User user});

  Future<void> createUserLike(
      {required String currentUserId, required String postId});
  Future<void> deleteUserLike(
      {required String currentUserId, required String postId});
}
