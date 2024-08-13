import '../Utils/constant.dart';

class UserService {
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
}
