abstract class UserFollowUsecase {
  Future<void> followUser({required String uid});
  Future<void> unfollowUser({required String uid});
}
