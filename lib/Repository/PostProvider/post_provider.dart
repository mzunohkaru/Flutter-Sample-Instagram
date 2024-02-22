import 'dart:async';
import 'package:instagram_clone/Model/Post/post.dart';
import 'package:instagram_clone/Utils/constant.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'post_provider.g.dart';

@riverpod
class PostProvider extends _$PostProvider {
  // 投稿データを取得・監視
  @override
  // async* : 非同期ストリームを生成
  Stream<List<Post>> build() async* {
    logger.d("Call: PostProvider");

    try {
      final currentUserUid = auth.currentUser?.uid;
      if (currentUserUid == null) {
        logger.e("DEBUG: Not found user ID");
      }

      // CloudStoreのコレクションからポストのデータをリアルタイムで取得する
      final postSnapshotStream = PostCollections.snapshots();

      // ストリームをリッスンし、各スナップショットに対して処理を行う
      await for (final postSnapshot in postSnapshotStream) {
        final posts = await Future.wait(postSnapshot.docs.map((doc) async {
          try {
            final postData = doc.data();
            final userDoc =
                await UserCollections.doc(postData['ownerUid']).get();
            final userData = userDoc.data();
            if (userData == null) {
              return null;
            }
            // Post型に変換
            final post = Post.fromJson({...postData, 'user': userData});
            final didLike =
                postData['likeUsers']?.contains(currentUserUid) ?? false;
            return post.copyWith(didLike: didLike);
          } catch (e) {
            logger.e("DEBUG: Failed to fetching post data with ${doc.id}", error: e);
            rethrow;
          }
        }).toList());

        // nullを除外し、Post型にキャストした後、リストとしてストリームに渡す
        yield posts.where((post) => post != null).cast<Post>().toList();
      }
    } catch (e) {
      logger.e('DEBUG: Failed to fetch all post data', error: e);
      rethrow;
    }
  }
}

/*
// StreamProvider

final postStreamProvider = StreamProvider<List<Post>>((ref) async* {
  try {
    final currentUserUid = ref.watch(currentUserUidProvider);
    if (currentUserUid == null) {
      throw Exception('DEBUG: Not found user ID');
    }
    final postSnapshotStream = PostCollections.snapshots();

    await for (final postSnapshot in postSnapshotStream) {
      final posts = await Future.wait(postSnapshot.docs.map((doc) async {
        try {
          final postData = doc.data();
          final userDoc = await UserCollections.doc(postData['ownerUid']).get();
          final userData = userDoc.data();
          if (userData == null) {
            return null;
          }
          final post = Post.fromJson({...postData, 'user': userData});
          final didLike =
              postData['likeUsers']?.contains(currentUserUid) ?? false;
          return post.copyWith(didLike: didLike);
        } catch (e) {
          rethrow;
        }
      }).toList());

      yield posts.where((post) => post != null).cast<Post>().toList();
    }
  } catch (e) {
    rethrow;
  }
});

*/