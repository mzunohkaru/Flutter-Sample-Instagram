import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Usecase/Post/PostUploadUsecase/post_upload_usecase_impl.dart';
import '../../../Utils/constant.dart';

class UploadPostViewModel {
  Future<void> uploadPost(
      {required WidgetRef ref,
      required List<XFile> imageFiles,
      required String caption}) async {
    try {
      // 画像をFirebase Storageにアップロード
      final postId = PostCollections.doc().id;

      final postImageUrls =
          await uploader.uploadStorage(imageFiles: imageFiles, postId: postId);

      await ref.read(postUploadUsecaseProvider).uploadPost(
          postId: postId, caption: caption, postImageUrls: postImageUrls);
    } catch (e) {
      logger.e("DEBUG: Failed to upload post", error: e);
    }
  }
}
