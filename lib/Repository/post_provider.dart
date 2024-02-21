import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Core/Comments/Model/comment.dart';
import 'package:instagram_clone/Model/Post/post.dart';
import 'package:instagram_clone/Model/User/user.dart';
import 'package:instagram_clone/Repository/firebase_provider.dart';
import 'package:instagram_clone/Utils/constant.dart';

// 投稿データを取得・監視
// async* : 非同期ストリームを生成
final postStreamProvider = StreamProvider<List<Post>>((ref) async* {
  try {
    // currentUserUidProviderから現在のユーザーIDを取得
    final currentUserUid = ref.watch(currentUserUidProvider);
    if (currentUserUid == null) {
      throw Exception('DEBUG: Not found user ID');
    }
    // Firestoreのコレクションからポストのデータをリアルタイムで取得する
    final postSnapshotStream = PostCollections.snapshots();

    // ストリームをリッスンし、各スナップショットに対して処理を行う
    await for (final postSnapshot in postSnapshotStream) {
      final posts = await Future.wait(postSnapshot.docs.map((doc) async {
        try {
          final postData = doc.data();
          final userDoc = await UserCollections.doc(postData['ownerUid']).get();
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
          print('投稿 ${doc.id} のユーザーデータ取得中にエラー: $e');
          rethrow;
        }
      }).toList());

      // nullを除外し、Post型にキャストした後、リストとしてストリームに渡す
      yield posts.where((post) => post != null).cast<Post>().toList();
    }
  } catch (e) {
    print('データ取得全体でエラー: $e');
    rethrow;
  }
});

// 投稿のコメントを取得・監視
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

// 「いいね」した投稿のみを取得・監視
final userLikedPostsStreamProvider = StreamProvider<List<Post>>((ref) async* {
  try {
    // currentUserUidProviderから現在のユーザーIDを取得
    final currentUserUid = ref.watch(currentUserUidProvider);
    if (currentUserUid == null) {
      throw Exception('DEBUG: Not found user ID');
    }

    // usersコレクションから現在のユーザーIDに一致するドキュメントのuser-likesサブコレクションを取得
    final userLikesSnapshotStream = UserCollections.doc(currentUserUid)
        .collection('user-likes')
        .snapshots();

    // ストリームをリッスンし、各スナップショットに対して処理を行う
    await for (final userLikesSnapshot in userLikesSnapshotStream) {
      final posts = await Future.wait(userLikesSnapshot.docs.map((doc) async {
        try {
          // user-likesサブコレクションのドキュメントID（投稿ID）を使用して、postsコレクションから一致するデータを取得
          final postDoc = await PostCollections.doc(doc.id).get();
          final postData = postDoc.data();
          if (postData == null) {
            return null;
          }
          // Post型に変換
          var post = Post.fromJson(postData);
          // ownerUidフィールドの値を取得して、User型のデータを取得
          final userDoc = await UserCollections.doc(post.ownerUid).get();
          final userData = userDoc.data();
          if (userData != null) {
            // User型のデータをpostのuserに格納
            post = post.copyWith(user: User.fromJson(userData));
          }
          // postデータのdidLikeをTrueに設定
          post = post.copyWith(didLike: true);
          return post;
        } catch (e) {
          print('投稿 ${doc.id} の取得中にエラー: $e');
          rethrow;
        }
      }).toList());

      // nullを除外し、Post型にキャストした後、リストとしてストリームに渡す
      yield posts.where((post) => post != null).cast<Post>().toList();
    }
  } catch (e) {
    print('データ取得全体でエラー: $e');
    rethrow;
  }
});
