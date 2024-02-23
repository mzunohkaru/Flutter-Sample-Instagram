import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Core/Profile/Service/profile_service.dart';
import 'package:instagram_clone/Model/User/user.dart';
import 'package:instagram_clone/Repository/UserProvider/current_user_provider.dart';
import 'package:instagram_clone/Utils/constant.dart';

class ProfileViewModel {
  Future<User?> fetchCurrentUser({required WidgetRef ref}) async {
    logger.d("Call: ProfileViewModel fetchCurrentUser");

    try {
      final currentUserUid = ref.watch(currentUserProviderProvider);
      if (currentUserUid == null) {
        throw Exception('DEBUG: Not found user ID');
      }

      final docSnapshot = await UserCollections.doc(currentUserUid).get();
      if (!docSnapshot.exists) {
        return null;
      }
      final data = docSnapshot.data();
      return User.fromJson(data as Map<String, dynamic>);
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
      final currentUserUid = ref.watch(currentUserProviderProvider);
      if (currentUserUid == null) {
        throw Exception('DEBUG: Not found user ID');
      }

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
    ref.read(currentUserProviderProvider.notifier).logOutUser();
  }

  Future follow({required WidgetRef ref, required String uid}) async {
    logger.d("Call: ProfileViewModel follow");

    final currentUserUid = ref.watch(currentUserProviderProvider);
    if (currentUserUid == null) {
      throw Exception('DEBUG: Not found user ID');
    }

    await userService.follow(currentUserUid: currentUserUid, uid: uid);
  }

  Future unfollow({required WidgetRef ref, required String uid}) async {
    logger.d("Call: ProfileViewModel unfollow");

    final currentUserUid = ref.watch(currentUserProviderProvider);
    if (currentUserUid == null) {
      throw Exception('DEBUG: Not found user ID');
    }
    await userService.unfollow(currentUserUid: currentUserUid, uid: uid);
  }

  Future<bool> checkIfUserFollowed({required String uid}) async {
    logger.d("Call: ProfileViewModel checkIfUserFollowed");

    final currentUserUid = auth.currentUser!.uid;

    return await userService.checkIfUserFollowed(
        currentUserUid: currentUserUid, uid: uid);
  }
}
