import 'package:instagram_clone/Model/Entity/Post/post_comment.dart';

abstract class PostCommentRepository {
  Stream<List<PostComment>> streamPostCommentList({required String postId});

  Future comment(
      {required String postId,
      required String commentText,
      required String currentUid});
}
