import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Utils/constant.dart';

import '../../../Usecase/Auth/BaseAuthenticatedUsecase/base_authenticated_usecase_impl.dart';

class UploadPostViewModel {
  Future<void> uploadPost(
      {required WidgetRef ref,
      required List<XFile> imageFiles,
      required String caption}) async {
    logger.d("Call: UploadPostViewModel uploadPost");

    try {
      final currentUserUid = ref.read(baseAuthenticatedUsecaseProvider).getCurrentUserId();

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
