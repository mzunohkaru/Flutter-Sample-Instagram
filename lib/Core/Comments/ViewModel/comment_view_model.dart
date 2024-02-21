import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Repository/firebase_provider.dart';
import 'package:instagram_clone/Utils/constant.dart';

class CommentViewModel {
  Future<void> comment(
      {required WidgetRef ref,
      required String postId,
      required String commentText}) async {
    try {
      // currentUserUidProviderから現在のユーザーIDを取得
      final currentUserUid = ref.watch(currentUserUidProvider);
      if (currentUserUid == null) {
        throw Exception('DEBUG: Not found user ID');
      }

      postService.comment(
          postId: postId,
          commentText: commentText,
          currentUserUid: currentUserUid);
    } catch (e) {
      print('コメントの保存中にエラーが発生しました: $e');
      throw Exception('DEBUG: Failed post comment');
    }
  }
}