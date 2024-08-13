import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Model/Entity/Post/post_comment.dart';
import 'post_comment_repository.dart';

part 'post_comment_repository_impl.g.dart';

@Riverpod(keepAlive: true)
PostCommentRepository postCommentRepository(PostCommentRepositoryRef ref) {
  return PostCommentRepositoryImpl(FirebaseFirestore.instance);
}

class PostCommentRepositoryImpl implements PostCommentRepository {
  PostCommentRepositoryImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<List<PostComment>> streamPostCommentList({required String postId}) {
    return _firestore
        .collection("posts")
        .doc(postId)
        .collection("post-comments")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PostComment.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future comment(
      {required String postId,
      required String commentText,
      required String currentUid}) async {
    final postDoc = _firestore.collection('posts').doc(postId);
    final postSnapshot = await postDoc.get();

    if (!postSnapshot.exists) {
      throw Exception('DEBUG: Not found post');
    }
    final postCommentId = postDoc.collection('post-comments').id;
    final postOwnerUid = postSnapshot.data()!['ownerUid'];
    final timestamp = Timestamp.now();

    final postCommentData = PostComment(
      commentId: postCommentId,
      postOwnerUid: postOwnerUid,
      commentText: commentText,
      postId: postId,
      createAt: timestamp,
      commentOwnerUid: currentUid,
      user: null,
    );

    final postComment = postCommentData.toJson();

    await postDoc.collection('post-comments').add(postComment);
  }
}
