import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Repository/PostRepository/Post/post_repository.dart';
import '../../../Repository/PostRepository/Post/post_repository_impl.dart';
import '../../../Repository/UserRepository/user_repository.dart';
import '../../../Repository/UserRepository/user_repository_impl.dart';
import '../../Auth/BaseAuthenticatedUsecase/base_authenticated_usecase.dart';
import '../../Auth/BaseAuthenticatedUsecase/base_authenticated_usecase_impl.dart';
import '../../User/UserFetchInfoUsecase/user_fetch_info_usecase.dart';
import '../../User/UserFetchInfoUsecase/user_fetch_info_usecase_impl.dart';
import 'post_like_usecase.dart';

part 'post_like_usecase_impl.g.dart';

@Riverpod(keepAlive: true)
PostLikeUsecaseImpl postLikeUsecase(
  PostLikeUsecaseRef ref,
) {
  final baseAuthenticatedUsecase = ref.watch(baseAuthenticatedUsecaseProvider);
  final postRepository = ref.watch(postRepositoryProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  final userFetchInfoUsecase = ref.watch(userFetchInfoUsecaseProvider);
  return PostLikeUsecaseImpl(
    baseAuthenticatedUsecase: baseAuthenticatedUsecase,
    postRepository: postRepository,
    userRepository: userRepository,
    userFetchInfoUsecase: userFetchInfoUsecase,
  );
}

class PostLikeUsecaseImpl implements PostLikeUsecase {
  const PostLikeUsecaseImpl({
    required BaseAuthenticatedUsecase baseAuthenticatedUsecase,
    required PostRepository postRepository,
    required UserRepository userRepository,
    required UserFetchInfoUsecase userFetchInfoUsecase,
  })  : _baseAuthenticatedUsecase = baseAuthenticatedUsecase,
        _postRepository = postRepository,
        _userRepository = userRepository,
        _userFetchInfoUsecase = userFetchInfoUsecase;

  final BaseAuthenticatedUsecase _baseAuthenticatedUsecase;
  final PostRepository _postRepository;
  final UserRepository _userRepository;
  final UserFetchInfoUsecase _userFetchInfoUsecase;

  @override
  Future<void> likePost({required String postId}) async {
    try {
      final uid = _baseAuthenticatedUsecase.getCurrentUserId();
      final postData = await _postRepository.fetchPost(postId: postId);
      final updatedPost = postData.copyWith(
        likes: postData.likes + 1,
        likeUsers: [...postData.likeUsers, uid],
      );
      await _postRepository.updatePost(post: updatedPost);
      final postOwnerUid = postData.ownerUid;
      final postOwnerUser =
          await _userFetchInfoUsecase.fetchUserInfo(uid: postOwnerUid);
      final updatedPostOwnerUser =
          postOwnerUser.copyWith(likes: postOwnerUser.likes + 1);
      await _userRepository.updateUser(user: updatedPostOwnerUser);
      await _userRepository.createUserLike(currentUserId: uid, postId: postId);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> unlikePost({required String postId}) async {
    try {
      final uid = _baseAuthenticatedUsecase.getCurrentUserId();
      final postData = await _postRepository.fetchPost(postId: postId);
      final updatedPost = postData.copyWith(
        likes: postData.likes - 1,
        likeUsers: postData.likeUsers.where((u) => u != uid).toList(),
      );
      await _postRepository.updatePost(post: updatedPost);
      final postOwnerUid = postData.ownerUid;
      final postOwnerUser =
          await _userFetchInfoUsecase.fetchUserInfo(uid: postOwnerUid);
      final updatedPostOwnerUser =
          postOwnerUser.copyWith(likes: postOwnerUser.likes - 1);
      await _userRepository.updateUser(user: updatedPostOwnerUser);
      await _userRepository.deleteUserLike(currentUserId: uid, postId: postId);
    } catch (e) {
      throw Exception(e);
    }
  }
}
