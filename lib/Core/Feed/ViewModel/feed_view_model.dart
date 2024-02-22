import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Repository/UserProvider/current_user_provider.dart';
import 'package:instagram_clone/Utils/constant.dart';

class FeedViewModel {
  Future<void> like({required WidgetRef ref, required String postId}) async {
    final currentUserUid = ref.watch(currentUserProviderProvider);
    if (currentUserUid == null) {
      throw Exception('DEBUG: Not found user ID');
    }

    try {
      final post = await postService.fetchPost(postId: postId);

      await postService.like(
          postId: postId,
          currentUserUid: currentUserUid,
          postLikes: post.likes);

      await userService.like(currentUserUid: currentUserUid, postId: postId);

      print("DEBUG: Post like");
    } catch (e) {
      print("投稿のいいねの保存中にエラーが発生しました: $e");
    }
  }

  Future<void> unlike({required WidgetRef ref, required String postId}) async {
    final currentUserUid = ref.watch(currentUserProviderProvider);
    if (currentUserUid == null) {
      throw Exception('DEBUG: Not found user ID');
    }

    try {
      final post = await postService.fetchPost(postId: postId);

      await postService.unlike(postId: postId, currentUserUid: currentUserUid, postLikes: post.likes);

      await userService.unlike(currentUserUid: currentUserUid, postId: postId);

      print("DEBUG: Post unlike");
    } catch (e) {
      print("投稿のいいねを削除にエラーが発生しました: $e");
    }
  }
}
