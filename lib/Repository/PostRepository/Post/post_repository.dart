import '../../../Model/Entity/Post/post.dart';

abstract class PostRepository {
  Future<Post> fetchPosts({required String postId});
}
