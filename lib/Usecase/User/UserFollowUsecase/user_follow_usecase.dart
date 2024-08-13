abstract class UserFollowUsecase {
  Future<bool> checkIfUserFollowed({required String uid});
  Future<void> followUser({required String uid});
  Future<void> unfollowUser({required String uid});
}
