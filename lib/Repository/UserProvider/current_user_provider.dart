import 'package:instagram_clone/Utils/constant.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'current_user_provider.g.dart';

@riverpod
class CurrentUserProvider extends _$CurrentUserProvider {
  // 現在のユーザーIDを提供するプロバイダ
  @override
  String? build() {
    logger.d("Call: CurrentUserProvider");

    return auth.currentUser?.uid;
  }

  void fetchUser() {
    state = auth.currentUser?.uid;
  }

  void logOutUser() {
    state = null;
  }
}

/*
// StateProvider

final currentUserUidProvider = StateProvider<String?>((ref) {
  return auth.currentUser?.uid;
});

*/