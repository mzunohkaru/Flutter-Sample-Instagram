abstract class PostLikeUsecase {
  Future<void> likePost({required String postId});
  Future<void> unlikePost({required String postId});
}
