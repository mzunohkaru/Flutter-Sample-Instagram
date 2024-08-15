import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Model/Entity/Post/post.dart';
import 'post_repository.dart';

part 'post_repository_impl.g.dart';

@Riverpod(keepAlive: true)
PostRepository postRepository(PostRepositoryRef ref) {
  return PostRepositoryImpl(FirebaseFirestore.instance);
}

class PostRepositoryImpl implements PostRepository {
  PostRepositoryImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Stream<List<Post>> streamPostList() {
    return _firestore
        .collection("posts")
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Post.fromJson(doc.data()))
          .toList();
    });
  }

  @override
  Future<Post> fetchPost({required String postId}) async {
    final postSnapshot = await _firestore.collection("posts").doc(postId).get();
    return Post.fromJson(postSnapshot.data()!);
  }
}
