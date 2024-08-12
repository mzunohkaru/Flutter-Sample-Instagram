import '../../../model/type/user_id.dart';

abstract class BaseAuthenticatedUsecase {
  UserId getCurrentUserId();
  Future<void> signOut();
}
