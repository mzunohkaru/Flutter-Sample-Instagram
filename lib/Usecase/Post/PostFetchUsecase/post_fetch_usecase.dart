import '../../../Model/Entity/Post/post.dart';

abstract class PostFetchUsecase {
  Stream<List<Post>> streamPostList();
  Future<bool> checkIfPostLiked({required String postId});
  Future<Post> fetchPost({required String postId});
}
