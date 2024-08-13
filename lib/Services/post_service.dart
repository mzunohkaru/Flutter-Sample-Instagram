import 'package:cloud_firestore/cloud_firestore.dart';

import '../Utils/constant.dart';

class PostService {
  Future uploadPost(
      {required String postId,
      required String currentUserUid,
      required String caption,
      required List<String> postImageUrls}) async {
    logger.d("Call: PostService uploadPost");

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
