import '../../../Model/Entity/User/user.dart';

abstract class AllUserUsecase {
  Future<List<User>> fetchAllUsers();
}