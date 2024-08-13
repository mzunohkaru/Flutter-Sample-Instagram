import '../../../Model/Entity/Post/post.dart';

abstract class PostRepository {
  Future<Post> fetchPost({required String postId});
}
