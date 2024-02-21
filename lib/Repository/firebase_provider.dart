import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Utils/constant.dart';

// 現在のユーザーIDを提供するプロバイダ
final currentUserUidProvider = StateProvider<String?>((ref) {
  return auth.currentUser?.uid;
});


