import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Model/Entity/User/user.dart';
import '../../../Repository/UserRepository/user_repository.dart';
import '../../../Repository/UserRepository/user_repository_impl.dart';
import 'all_user_usecase.dart';

part 'all_user_usecase_impl.g.dart';

@Riverpod(keepAlive: true)
AllUserUsecaseImpl allUserUsecase(
  AllUserUsecaseRef ref,
) {
  final userRepository = ref.watch(userRepositoryProvider);
  return AllUserUsecaseImpl(
    userRepository: userRepository,
  );
}

class AllUserUsecaseImpl implements AllUserUsecase {
  const AllUserUsecaseImpl({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final UserRepository _userRepository;

  @override
  Future<List<User>> fetchAllUsers() {
    return _userRepository.getAllUsers();
  }
}
