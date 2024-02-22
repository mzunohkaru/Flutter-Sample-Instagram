import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Repository/UserProvider/current_user_provider.dart';
import 'package:instagram_clone/Utils/constant.dart';

class ProfileService {
  Future<String> _uploadImage(
      {required File file, required String currentUserUid}) async {
    // メタデータを設定
    SettableMetadata metadata = SettableMetadata(
      contentType: 'image/jpeg', // ここでファイルのタイプを指定します
    );

    /// Firebase Cloud Storageにアップロード
    final storageRef =
        storage.ref().child('profile/$currentUserUid').putFile(file, metadata);

    final snapshot = await storageRef;
    return snapshot.ref.getDownloadURL();
  }

  Future<void> updateProfileData({
    required String currentUserUid,
    required String username,
    required String bio,
    required File? profileImage,
  }) async {

    Map<String, dynamic> updateData = {
      'username': username,
      'bio': bio,
    };

    if (profileImage != null) {
      // userがプロフィール画像を保存しているか確認
      final snapshot = await UserCollections.doc(currentUserUid).get();
      final existingImageUrl = snapshot.data()?['profileImageUrl'];
      // userがプロフィール画像を保存している場合
      if (existingImageUrl != null) {
        try {
          // URLに基づいてStorage内のファイルへの参照
          final existingFileRef = storage.refFromURL(existingImageUrl);
          await existingFileRef.delete();
        } catch (e) {
          print("既存のプロファイル画像の削除に失敗しました: $e");
        }
      }
      // プロフィール画像をアップデート
      var imageUrl = await _uploadImage(
          file: profileImage, currentUserUid: currentUserUid);
      updateData['profileImageUrl'] = imageUrl;
    }

    final userDoc = UserCollections.doc(currentUserUid);

    await userDoc.update(updateData).catchError((e) {
      throw Exception("プロファイルデータの更新に失敗しました: $e");
    });
  }
}
