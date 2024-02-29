import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Utils/constant.dart';

class Uploader {
  Future<List<String>> uploadStorage(
      {required List<XFile> imageFiles, required String postId}) async {
    logger.d("Call: Uploader uploadStorage");

    List<String> downloadUrls = [];
    for (XFile imageFile in imageFiles) {
      // 一意のファイル名を生成します。例: image_123456789.jpg
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      File file = File(imageFile.path);

      // Firebase Storageにファイルをアップロードします。
      var uploadTask =
          storage.ref('posts').child(postId).child(fileName).putFile(file);
      var snapshot = await uploadTask;

      // アップロードしたファイルのダウンロードURLを取得します。
      String downloadUrl = await snapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }

    return downloadUrls;
  }
}
