abstract class PostUploadUsecase {
  Future<void> uploadPost(
      {required String postId,
      required String caption,
      required List<String> postImageUrls});
}
