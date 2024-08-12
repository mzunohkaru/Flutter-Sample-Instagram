import 'package:instagram_clone/Model/Entity/Post/post_comment.dart';

abstract class PostCommentRepository {
  Stream<List<PostComment>> streamPostCommentList({required String postId});
}
