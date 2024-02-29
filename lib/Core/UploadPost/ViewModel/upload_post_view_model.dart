import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Repository/UserProvider/current_user_provider.dart';
import 'package:instagram_clone/Utils/constant.dart';

class UploadPostViewModel {
  Future<void> uploadPost(
      {required WidgetRef ref,
      required List<XFile> imageFiles,
      required String caption}) async {
    logger.d("Call: UploadPostViewModel uploadPost");

    try {
      final currentUserUid = ref.watch(currentUserProviderProvider);
      if (currentUserUid == null) {
        throw Exception('DEBUG: Not found user ID');
      }

      // 画像をFirebase Storageにアップロード
      final postId = PostCollections.doc().id;

      final postImageUrls =
          await uploader.uploadStorage(imageFiles: imageFiles, postId: postId);

      postService.uploadPost(
          postId: postId,
          currentUserUid: currentUserUid,
          caption: caption,
          postImageUrls: postImageUrls);
    } catch (e) {
      logger.e("DEBUG: Failed to upload post", error: e);
    }
  }
}
