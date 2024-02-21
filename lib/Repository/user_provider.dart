import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Model/User/user.dart';
import 'package:instagram_clone/Repository/firebase_provider.dart';
import 'package:instagram_clone/Utils/constant.dart';

final usersProvider = FutureProvider<List<User>>((ref) async {
  try {
    // currentUserUidProviderから現在のユーザーIDを取得
    final currentUserUid = ref.watch(currentUserUidProvider);
    if (currentUserUid == null) {
      throw Exception('DEBUG: Not found user ID');
    }

    // usersコレクションの全データを取得
    final usersSnapshot = await UserCollections.get();
    // 取得したデータをUser型に変換し、現在のユーザーを除外
    final users = usersSnapshot.docs
        .map((doc) {
          return User.fromJson(doc.data());
        })
        .where((user) => user.userId != currentUserUid)
        .toList();
    return users;
  } catch (e) {
    print('ユーザーデータの取得中にエラーが発生しました: $e');
    throw Exception('ユーザーデータの取得に失敗しました。');
  }
});
