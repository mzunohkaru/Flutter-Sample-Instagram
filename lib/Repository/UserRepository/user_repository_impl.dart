import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../Model/Entity/User/user.dart';
import 'user_repository.dart';

part 'user_repository_impl.g.dart';

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) {
  return UserRepositoryImpl(FirebaseFirestore.instance);
}

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._firestore);

  final FirebaseFirestore _firestore;

  @override
  Future<User> fetchUser({required String uid}) {
    return _firestore.collection("users").doc(uid).get().then((value) {
      return User.fromJson(value.data()!);
    });
  }

  @override
  Future<List<User>> getAllUsers() {
    return _firestore.collection('users').get().then((snapshot) async {
      final users =
          snapshot.docs.map((doc) => User.fromJson(doc.data())).toList();
      return users;
    });
  }

  @override
  Future<bool> checkIfUserFollowed(
      {required String currentUid, required String uid}) async {
    final snapshot = await _firestore
        .collection("following")
        .doc(currentUid)
        .collection("user-following")
        .doc(uid)
        .get();

    return snapshot.exists;
  }

  @override
  Future<void> followUser(
      {required String currentUid, required String uid}) async {
    await _firestore
        .collection("following")
        .doc(currentUid)
        .collection("user-following")
        .doc(uid)
        .set({});

    await _firestore
        .collection("followers")
        .doc(uid)
        .collection("user-followers")
        .doc(currentUid)
        .set({});

    await _firestore
        .collection('users')
        .doc(currentUid)
        .update({'following': FieldValue.increment(1)});

    await _firestore
        .collection('users')
        .doc(uid)
        .update({'followers': FieldValue.increment(1)});
  }

  @override
  Future<void> unfollowUser(
      {required String currentUid, required String uid}) async {
    await _firestore
        .collection("following")
        .doc(currentUid)
        .collection("user-following")
        .doc(uid)
        .delete();

    await _firestore
        .collection("followers")
        .doc(uid)
        .collection("user-followers")
        .doc(currentUid)
        .delete();

    await _firestore
        .collection('users')
        .doc(currentUid)
        .update({'following': FieldValue.increment(-1)});

    await _firestore
        .collection('users')
        .doc(uid)
        .update({'followers': FieldValue.increment(-1)});
  }

  @override
  Future<bool> checkIfPostLiked({required String currentUserId, required String postId}) async {
    final userLikedSnapshot = await _firestore
        .collection("users")
        .doc(currentUserId)
        .collection("user-likes")
        .doc(postId)
        .get();
    return userLikedSnapshot.exists;
  }
}
