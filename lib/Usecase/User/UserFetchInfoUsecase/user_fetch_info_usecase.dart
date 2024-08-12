import 'package:instagram_clone/Model/User/user.dart';

abstract class UserFetchInfoUsecase {
  Future<User> fetchUserInfo({required String uid});
}
