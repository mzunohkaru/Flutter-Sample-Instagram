

// final v = StreamProvider.family<List<Post>, String>((ref, userId) async* {
//   try {
//     // postsコレクションからownerUidがuserIdに一致するデータをリアルタイムで監視
//     final userPostsSnapshotStream = PostCollections.where('ownerUid', isEqualTo: userId).snapshots();

//     // ストリームをリッスンし、各スナップショットに対して処理を行う
//     await for (final userPostsSnapshot in userPostsSnapshotStream) {
//       final posts = await Future.wait(userPostsSnapshot.docs.map((doc) async {
//         try {
//           final postData = doc.data();
//           if (postData == null) {
//             return [];
//           }
//           // Post型に変換
//           var post = Post.fromJson(postData);
//           // ownerUidフィールドの値を取得して、User型のデータを取得
//           final userDoc = await UserCollections.doc(post.ownerUid).get();
//           final userData = userDoc.data();
//           if (userData != null) {
//             // User型のデータをpostのuserに格納
//             post = post.copyWith(user: User.fromJson(userData));
//           }
//           return post;
//         } catch (e) {
//           print('投稿 ${doc.id} の取得中にエラー: $e');
//           rethrow;
//         }
//       }).toList());

//       // nullを除外し、Post型にキャストした後、リストとしてストリームに渡す
//       yield posts.where((post) => post != null).cast<Post>().toList();
//     }
//   } catch (e) {
//     print('データ取得全体でエラー: $e');
//     rethrow;
//   }
// });
