import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Repository/UserRepository/user_repository.dart';
import '../../../Repository/UserRepository/user_repository_impl.dart';
import '../../Auth/BaseAuthenticatedUsecase/base_authenticated_usecase.dart';
import '../../Auth/BaseAuthenticatedUsecase/base_authenticated_usecase_impl.dart';
import 'user_follow_usecase.dart';

part 'user_follow_usecase_impl.g.dart';

@Riverpod(keepAlive: true)
UserFollowUsecaseImpl userFollowUsecase(
  UserFollowUsecaseRef ref,
) {
  final userRepository = ref.watch(userRepositoryProvider);
  final baseAuthenticatedUsecase = ref.watch(baseAuthenticatedUsecaseProvider);
  return UserFollowUsecaseImpl(
    userRepository: userRepository,
    baseAuthenticatedUsecase: baseAuthenticatedUsecase,
  );
}

class UserFollowUsecaseImpl implements UserFollowUsecase {
  const UserFollowUsecaseImpl({
    required UserRepository userRepository,
    required BaseAuthenticatedUsecase baseAuthenticatedUsecase,
  })  : _userRepository = userRepository,
        _baseAuthenticatedUsecase = baseAuthenticatedUsecase;

  final UserRepository _userRepository;
  final BaseAuthenticatedUsecase _baseAuthenticatedUsecase;

  @override
  Future<bool> checkIfUserFollowed({required String uid}) async {
    final currentUid = _baseAuthenticatedUsecase.getCurrentUserId();
    return await _userRepository.checkIfUserFollowed(
        currentUid: currentUid, uid: uid);
  }

  @override
  Future<void> followUser({required String uid}) async {
    final currentUid = _baseAuthenticatedUsecase.getCurrentUserId();
    await _userRepository.followUser(currentUid: currentUid, uid: uid);
  }

  @override
  Future<void> unfollowUser({required String uid}) async {
    final currentUid = _baseAuthenticatedUsecase.getCurrentUserId();
    await _userRepository.unfollowUser(currentUid: currentUid, uid: uid);
  }
}
