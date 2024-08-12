import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Core/Profile/Service/profile_service.dart';
import 'package:instagram_clone/Model/Post/post.dart';
import 'package:instagram_clone/Model/User/user.dart';
import 'package:instagram_clone/Utils/constant.dart';

import '../../../Usecase/Auth/BaseAuthenticatedUsecase/base_authenticated_usecase_impl.dart';

class ProfileViewModel {
  Future<User?> fetchUser({required String userId}) async {
    logger.d("Call: ProfileViewModel fetchUser");

    try {
      // 引数のユーザーの投稿データを取得
      final postsQuerySnapshot =
          await PostCollections.where('ownerUid', isEqualTo: userId).get();

      // Post型に変換
      final posts = postsQuerySnapshot.docs
          .map((doc) => Post.fromJson(doc.data()))
          .toList();

      // 引数のユーザーのユーザーデータを取得
      final userDoc = await UserCollections.doc(userId).get();
      if (!userDoc.exists) {
        throw Exception('User not found');
      }

      final userData = userDoc.data()!;
      return User.fromJson({
        'userId': userData['userId'],
        'username': userData['username'],
        'bio': userData['bio'],
        'profileImageUrl': userData['profileImageUrl'],
        'followers': userData['followers'],
        'following': userData['following'],
        'likes': userData['likes'],
        'post': posts.map((post) => post.toJson()).toList(),
      });
    } catch (e) {
      logger.e("DEBUG: Failed to fetching username", error: e);
      return null;
    }
  }

  Future<void> updateProfile({
    required WidgetRef ref,
    required String username,
    required String bio,
    required File? profileImage,
  }) async {
    logger.d("Call: ProfileViewModel updateProfile");

    try {
      final currentUserUid =
          ref.read(baseAuthenticatedUsecaseProvider).getCurrentUserId();

      await ProfileService().updateProfileData(
        currentUserUid: currentUserUid,
        username: username,
        bio: bio,
        profileImage: profileImage,
      );
    } catch (e) {
      logger.e("DEBUG: Failed to update data with profile", error: e);
    }
  }

  Future signOut({required WidgetRef ref}) async {
    logger.d("Call: ProfileViewModel signOut");

    await authService.signOut();
  }

  Future follow({required WidgetRef ref, required String uid}) async {
    logger.d("Call: ProfileViewModel follow");

    final currentUserUid =
        ref.read(baseAuthenticatedUsecaseProvider).getCurrentUserId();

    await userService.follow(currentUserUid: currentUserUid, uid: uid);
  }

  Future unfollow({required WidgetRef ref, required String uid}) async {
    logger.d("Call: ProfileViewModel unfollow");

    final currentUserUid =
        ref.read(baseAuthenticatedUsecaseProvider).getCurrentUserId();

    await userService.unfollow(currentUserUid: currentUserUid, uid: uid);
  }

  Future<bool> checkIfUserFollowed({required String uid}) async {
    logger.d("Call: ProfileViewModel checkIfUserFollowed");

    final currentUserUid = auth.currentUser!.uid;

    return await userService.checkIfUserFollowed(
        currentUserUid: currentUserUid, uid: uid);
  }
}
