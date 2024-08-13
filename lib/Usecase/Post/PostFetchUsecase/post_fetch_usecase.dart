import '../../../Model/Entity/Post/post.dart';

abstract class PostFetchUsecase {
  Future<Post> fetchPost({required String postId});
}
