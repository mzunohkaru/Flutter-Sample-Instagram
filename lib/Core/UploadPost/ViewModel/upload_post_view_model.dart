import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Repository/firebase_provider.dart';
import 'package:instagram_clone/Utils/constant.dart';

class UploadPostViewModel {
  Future<void> uploadPost(
      {required WidgetRef ref,
      required XFile imageFile,
      required String caption}) async {
    try {
      // currentUserUidProviderから現在のユーザーIDを取得
      final currentUserUid = ref.watch(currentUserUidProvider);
      if (currentUserUid == null) {
        throw Exception('DEBUG: Not found user ID');
      }

      // 画像をFirestorageにアップロード
      final postId = PostCollections.doc().id;

      final postImageUrl =
          await uploader.uploadStorage(imageFile: imageFile, postId: postId);

      postService.uploadPost(postId: postId, currentUserUid: currentUserUid, caption: caption, postImageUrl: postImageUrl);

    } catch (e) {
      debugPrint("投稿のアップロードに失敗しました: $e");
    }
  }
}
