import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Core/Profile/Service/profile_service.dart';
import 'package:instagram_clone/Model/User/user.dart';
import 'package:instagram_clone/Repository/UserProvider/current_user_provider.dart';
import 'package:instagram_clone/Utils/constant.dart';

class ProfileViewModel {
  Future<User?> fetchCurrentUser({required WidgetRef ref}) async {
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
      print("DEBUG: fetching username: $e");
      return null;
    }
  }

  Future<void> updateProfile({
    required WidgetRef ref,
    required String username,
    required String bio,
    required File? profileImage,
  }) async {
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
      print("プロファイルの更新中にエラーが発生しました: $e");
    }
  }

  Future signOut({required WidgetRef ref}) async {
    await authService.signOut();
    ref.read(currentUserProviderProvider.notifier).logOutUser();
  }

  Future follow({required WidgetRef ref, required String uid}) async {
    final currentUserUid = ref.watch(currentUserProviderProvider);
    if (currentUserUid == null) {
      throw Exception('DEBUG: Not found user ID');
    }

    await userService.follow(currentUserUid: currentUserUid, uid: uid);
  }

  Future unfollow({required WidgetRef ref, required String uid}) async {
    final currentUserUid = ref.watch(currentUserProviderProvider);
    if (currentUserUid == null) {
      throw Exception('DEBUG: Not found user ID');
    }
    await userService.unfollow(currentUserUid: currentUserUid, uid: uid);
  }

  Future<bool> checkIfUserFollowed({required String uid}) async {
    final currentUserUid = auth.currentUser!.uid;

    return await userService.checkIfUserFollowed(
        currentUserUid: currentUserUid, uid: uid);
  }
}
