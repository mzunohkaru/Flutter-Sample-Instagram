import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Repository/UserProvider/current_user_provider.dart';
import 'package:instagram_clone/Utils/constant.dart';

class UploadPostViewModel {
  Future<void> uploadPost(
      {required WidgetRef ref,
      required XFile imageFile,
      required String caption}) async {
    logger.d("Call: UploadPostViewModel uploadPost");

    try {
      final currentUserUid = ref.watch(currentUserProviderProvider);
      if (currentUserUid == null) {
        throw Exception('DEBUG: Not found user ID');
      }

      // 画像をFirestorageにアップロード
      final postId = PostCollections.doc().id;

      final postImageUrl =
          await uploader.uploadStorage(imageFile: imageFile, postId: postId);

      postService.uploadPost(
          postId: postId,
          currentUserUid: currentUserUid,
          caption: caption,
          postImageUrl: postImageUrl);
    } catch (e) {
      logger.e("DEBUG: Failed to upload post", error: e);
    }
  }
}
