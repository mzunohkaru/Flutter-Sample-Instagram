import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Model/Entity/User/user.dart';
import '../../../Usecase/Auth/BaseAuthenticatedUsecase/base_authenticated_usecase.dart';
import '../../../Usecase/Auth/BaseAuthenticatedUsecase/base_authenticated_usecase_impl.dart';
import '../../../Usecase/User/AllUserUsecase/all_user_usecase.dart';
import '../../../Usecase/User/AllUserUsecase/all_user_usecase_impl.dart';
import '../../../Utils/constant.dart';

part 'user_controller.g.dart';

@riverpod
class UserController extends _$UserController {
  late final BaseAuthenticatedUsecase _baseAuthenticatedUsecase;
  late final AllUserUsecase _allUserUsecase;
  @override
  Future<List<User>> build() async {
    _baseAuthenticatedUsecase = ref.read(baseAuthenticatedUsecaseProvider);
    _allUserUsecase = ref.read(allUserUsecaseProvider);
    try {
      final currentUserUid = _baseAuthenticatedUsecase.getCurrentUserId();

      final allUsers = await _allUserUsecase.fetchAllUsers();

      // 取得したデータから現在のユーザーを除外
      final users =
          allUsers.where((user) => user.userId != currentUserUid).toList();

      return users;
    } catch (e) {
      logger.e("DEBUG: Failed to fetching user data", error: e);
      rethrow;
    }
  }
}
