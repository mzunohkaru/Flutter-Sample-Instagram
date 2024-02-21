import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/Utils/constant.dart';

class Uploader {
  Future<String> uploadStorage(
      {required XFile imageFile, required String postId}) async {
    final file = File(imageFile.path);
    final uploadTask = storage.ref('posts/$postId').putFile(file);
    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}
