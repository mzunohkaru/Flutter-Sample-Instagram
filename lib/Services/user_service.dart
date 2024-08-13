import '../Model/Entity/User/user.dart';
import '../Utils/constant.dart';

class UserService {
  Future<User> fetchUser({required String uid}) async {
    logger.d("Call: UserService fetchUser");

    final userSnapshot = await UserCollections.doc(uid).get();
    return User.fromJson(userSnapshot.data()!);
  }

  Future like({required String currentUserUid, required String postId}) async {
    logger.d("Call: UserService like");

    await UserCollections.doc(currentUserUid)
        .collection('user-likes')
        .doc(postId)
        .set({});
  }

  Future unlike(
      {required String currentUserUid, required String postId}) async {
    logger.d("Call: UserService unlike");

    await UserCollections.doc(currentUserUid)
        .collection('user-likes')
        .doc(postId)
        .delete();
  }

  Future<bool> checkIfUserFollowed(
      {required String currentUserUid, required String uid}) async {
    logger.d("Call: UserService checkIfUserFollowed");

    final snapshot = await FollowingCollections.doc(currentUserUid)
        .collection("user-following")
        .doc(uid)
        .get();

    return snapshot.exists;
  }
}
