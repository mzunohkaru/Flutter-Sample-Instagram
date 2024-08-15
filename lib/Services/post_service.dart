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
}
