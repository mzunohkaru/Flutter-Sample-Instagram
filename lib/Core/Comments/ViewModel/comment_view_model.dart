import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Utils/constant.dart';

import '../../../Usecase/Auth/BaseAuthenticatedUsecase/base_authenticated_usecase_impl.dart';

class CommentViewModel {
  Future<void> comment(
      {required WidgetRef ref,
      required String postId,
      required String commentText}) async {
    logger.d("Call: CommentViewModel comment");

    try {
      final currentUserUid =
          ref.read(baseAuthenticatedUsecaseProvider).getCurrentUserId();

      postService.comment(
          postId: postId,
          commentText: commentText,
          currentUserUid: currentUserUid);
    } catch (e) {
      logger.e("DEBUG: Failed to saving comment", error: e);
      throw Exception('DEBUG: Failed post comment');
    }
  }
}
