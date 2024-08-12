import 'package:instagram_clone/Model/Entity/User/user.dart';

abstract class UserFetchInfoUsecase {
  Future<User> fetchUserInfo({required String uid});
}
