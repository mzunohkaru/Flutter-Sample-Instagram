import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Utils/constant.dart';

import '../../../Usecase/Post/PostCommentUsecasee/post_comment_usecase_impl.dart';

class CommentViewModel {
  Future<void> comment(
      {required WidgetRef ref,
      required String postId,
      required String commentText}) async {
    logger.d("Call: CommentViewModel comment");

    try {
      await ref.read(postCommentUsecaseProvider).comment(
            postId: postId,
            commentText: commentText,
          );
    } catch (e) {
      logger.e("DEBUG: Failed to saving comment", error: e);
      throw Exception('DEBUG: Failed post comment');
    }
  }
}
