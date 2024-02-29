import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';
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

      // サムネイルを圧縮
      final compressedImage = await _compressImage(imageFile: file);

      // Firebase Storageにファイルをアップロードします。
      var uploadTask = storage
          .ref('posts')
          .child(postId)
          .child(fileName)
          .putFile(compressedImage);
      var snapshot = await uploadTask;

      // アップロードしたファイルのダウンロードURLを取得します。
      String downloadUrl = await snapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }

    return downloadUrls;
  }

  // 画像を圧縮するメソッドを追加
  Future<File> _compressImage({required File imageFile}) async {
    try {
      final filePath = imageFile.absolute.path;

      // 圧縮後の画像ファイルのパスを生成
      final outPath = "${filePath}_compressed.jpg";

      // filePathの画像を圧縮
      final compressedImage = await FlutterImageCompress.compressAndGetFile(
        filePath,
        outPath,
        quality: 80,
      );
      return File(compressedImage!.path);
    } catch (e) {
      logger.e("DEBUG: Failed to compressed image", error: e);
      return imageFile;
    }
  }
}
