import '../../../Model/Entity/Post/post.dart';

abstract class PostRepository {
  Stream<List<Post>> streamPostList();
  Future<Post> fetchPost({required String postId});

  Future<void> createPost({required Post post});
  Future<void> updatePost({required Post post});
}
