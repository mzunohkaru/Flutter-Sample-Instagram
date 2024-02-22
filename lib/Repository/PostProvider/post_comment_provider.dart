import 'dart:async';
import 'package:instagram_clone/Core/Comments/Model/comment.dart';
import 'package:instagram_clone/Utils/constant.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'post_comment_provider.g.dart';

@riverpod
class PostCommentProvider extends _$PostCommentProvider {
  // 投稿のコメントを取得・監視
  @override
  Stream<List<Comment>> build(postId) async* {
    logger.d("Call: PostCommentProvider");

    try {
      final commentsSnapshotStream =
          PostCollections.doc(postId).collection('post-comments').snapshots();

      // ストリームをリッスンし、各スナップショットに対して処理を行う
      await for (final commentsSnapshot in commentsSnapshotStream) {
        final comments =
            await Future.wait(commentsSnapshot.docs.map((doc) async {
          try {
            final commentData = doc.data();
            final userDoc =
                await UserCollections.doc(commentData['commentOwnerUid']).get();
            final userData = userDoc.data();
            if (userData == null) {
              return null;
            }
            // Comment型に変換
            final comment =
                Comment.fromJson({...commentData, 'user': userData});
            return comment;
          } catch (e) {
            logger.e('DEBUG: Failed to fetching comment data with ${doc.id}', error: e);
            rethrow;
          }
        }).toList());

        yield comments
            .where((comment) => comment != null)
            .cast<Comment>()
            .toList();
      }
    } catch (e) {
      logger.e('DEBUG: Failed to fetch all comment data', error: e);
      rethrow;
    }
  }
}


/*
// StreamProvider

final postCommentsStreamProvider =
    // 引数として postId を受け取る
    StreamProvider.family<List<Comment>, String>((ref, postId) async* {
  try {
    final commentsSnapshotStream =
        PostCollections.doc(postId).collection('post-comments').snapshots();

    // ストリームをリッスンし、各スナップショットに対して処理を行う
    await for (final commentsSnapshot in commentsSnapshotStream) {
      final comments = await Future.wait(commentsSnapshot.docs.map((doc) async {
        try {
          final commentData = doc.data();
          final userDoc =
              await UserCollections.doc(commentData['commentOwnerUid']).get();
          final userData = userDoc.data();
          if (userData == null) {
            return null;
          }
          // Comment型に変換
          final comment = Comment.fromJson({...commentData, 'user': userData});
          return comment;
        } catch (e) {
          print('コメント ${doc.id} のユーザーデータ取得中にエラー: $e');
          rethrow;
        }
      }).toList());

      yield comments
          .where((comment) => comment != null)
          .cast<Comment>()
          .toList();
    }
  } catch (e) {
    print('コメントデータ取得全体でエラー: $e');
    rethrow;
  }
});

*/