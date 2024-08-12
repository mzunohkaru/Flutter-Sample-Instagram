import '../../../Model/Entity/Post/post_comment.dart';

abstract class PostCommentFetchUsecase {
  Stream<List<PostComment>> fetchPostCommentList({required String postId});
}
