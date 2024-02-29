import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/Model/Post/post.dart';
import 'package:instagram_clone/Utils/constant.dart';

class PostService {
  Future<Post> fetchPost({required String postId}) async {
    logger.d("Call: PostService fetchPost");

    final postSnapshot = await PostCollections.doc(postId).get();
    return Post.fromJson(postSnapshot.data()!);
  }

  Future uploadPost(
      {required String postId,
      required String currentUserUid,
      required String caption,
      required List<String> postImageUrls}) async {
    logger.d("Call: PostService uploadPost");
    // FirebaseStoreに保存
    await PostCollections.doc(postId).set({
      'postId': postId,
      'ownerUid': currentUserUid,
      'caption': caption,
      'postImageUrls': postImageUrls,
      'createAt': Timestamp.now(),
      'likes': 0,
      'likeUsers': [],
      'didLike': false,
    });
  }

  Future comment(
      {required String postId,
      required String commentText,
      required String currentUserUid}) async {
    logger.d("Call: PostService comment");

    final postDoc = PostCollections.doc(postId);
    final postSnapshot = await postDoc.get();

    if (!postSnapshot.exists) {
      throw Exception('DEBUG: Not found post');
    }
    final postCommentId = postDoc.collection('post-comments').id;
    final postOwnerUid = postSnapshot.data()!['ownerUid'];
    final timestamp = Timestamp.now();

    await postDoc.collection('post-comments').add({
      'commentId': postCommentId,
      'postOwnerUid': postOwnerUid,
      'commentText': commentText,
      'postId': postId,
      'createAt': timestamp,
      'commentOwnerUid': currentUserUid,
    });
  }

  Future like(
      {required String postId,
      required String currentUserUid,
      required int postLikes}) async {
    logger.d("Call: PostService like");

    await PostCollections.doc(postId).update({
      'likeUsers': FieldValue.arrayUnion([currentUserUid]),
      'likes': postLikes + 1
    });

    final postOwnerUid =
        (await PostCollections.doc(postId).get()).data()!['ownerUid'];
    await UserCollections.doc(postOwnerUid)
        .update({'likes': FieldValue.increment(1)});
  }

  Future unlike(
      {required String postId,
      required String currentUserUid,
      required int postLikes}) async {
    logger.d("Call: PostService unlike");

    await PostCollections.doc(postId).update({
      'likeUsers': FieldValue.arrayRemove([currentUserUid]),
      'likes': postLikes - 1
    });

    final postOwnerUid =
        (await PostCollections.doc(postId).get()).data()!['ownerUid'];
    await UserCollections.doc(postOwnerUid)
        .update({'likes': FieldValue.increment(-1)});
  }
}
