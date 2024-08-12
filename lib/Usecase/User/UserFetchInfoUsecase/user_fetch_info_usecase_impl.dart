import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Model/User/user.dart';
import '../../../Repository/UserRepository/user_repository.dart';
import '../../../Repository/UserRepository/user_repository_impl.dart';
import 'user_fetch_info_usecase.dart';

part 'user_fetch_info_usecase_impl.g.dart';

@Riverpod(keepAlive: true)
UserFetchInfoUsecaseImpl userFetchInfoUsecase(
  UserFetchInfoUsecaseRef ref,
) {
  final userRepository = ref.watch(userRepositoryProvider);
  return UserFetchInfoUsecaseImpl(
    userRepository: userRepository,
  );
}

class UserFetchInfoUsecaseImpl implements UserFetchInfoUsecase {
  const UserFetchInfoUsecaseImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<User> fetchUserInfo({required String uid}) async {
    final user = await _userRepository.fetchUser(uid: uid);
    return user;
  }
}
