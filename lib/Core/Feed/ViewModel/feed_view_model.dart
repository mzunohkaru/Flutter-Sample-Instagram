import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Utils/constant.dart';

import '../../../Usecase/Auth/BaseAuthenticatedUsecase/base_authenticated_usecase_impl.dart';
import '../../../Usecase/Post/PostFetchUsecase/post_fetch_usecase_impl.dart';

class FeedViewModel {
  Future<void> like({required WidgetRef ref, required String postId}) async {
    logger.d("Call: FeedViewModel like");

    final currentUserUid =
        ref.read(baseAuthenticatedUsecaseProvider).getCurrentUserId();

    try {
      final post =
          await ref.read(postFetchUsecaseProvider).fetchPosts(postId: postId);

      await postService.like(
          postId: postId,
          currentUserUid: currentUserUid,
          postLikes: post.likes);

      await userService.like(currentUserUid: currentUserUid, postId: postId);
    } catch (e) {
      logger.e("DEBUG: Failed to saving liked with post", error: e);
    }
  }

  Future<void> unlike({required WidgetRef ref, required String postId}) async {
    logger.d("Call: FeedViewModel unlike");

    final currentUserUid =
        ref.read(baseAuthenticatedUsecaseProvider).getCurrentUserId();

    try {
      final post =
          await ref.read(postFetchUsecaseProvider).fetchPosts(postId: postId);

      await postService.unlike(
          postId: postId,
          currentUserUid: currentUserUid,
          postLikes: post.likes);

      await userService.unlike(currentUserUid: currentUserUid, postId: postId);
    } catch (e) {
      logger.e("DEBUG: Failed to saving unlike with post", error: e);
    }
  }
}
