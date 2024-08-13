import '../../../Model/Entity/Post/post.dart';

abstract class PostFetchUsecase {
  Future<Post> fetchPosts({required String postId});
}
