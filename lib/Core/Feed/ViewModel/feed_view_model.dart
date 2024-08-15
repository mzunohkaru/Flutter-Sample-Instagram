import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../Usecase/Post/PostLikeUsecase/post_like_usecase_impl.dart';
import '../../../Utils/constant.dart';

class FeedViewModel {
  Future<void> like({required WidgetRef ref, required String postId}) async {
    try {
      await ref.read(postLikeUsecaseProvider).likePost(postId: postId);
    } catch (e) {
      logger.e("DEBUG: Failed to saving liked with post", error: e);
    }
  }

  Future<void> unlike({required WidgetRef ref, required String postId}) async {
    try {
      await ref.read(postLikeUsecaseProvider).unlikePost(postId: postId);
    } catch (e) {
      logger.e("DEBUG: Failed to saving unlike with post", error: e);
    }
  }
}
