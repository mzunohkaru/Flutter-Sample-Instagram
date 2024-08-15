import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Model/Entity/Post/post.dart';
import '../../../Repository/PostRepository/Post/post_repository.dart';
import '../../../Repository/PostRepository/Post/post_repository_impl.dart';
import '../../../Repository/UserRepository/user_repository.dart';
import '../../../Repository/UserRepository/user_repository_impl.dart';
import '../../Auth/BaseAuthenticatedUsecase/base_authenticated_usecase.dart';
import '../../Auth/BaseAuthenticatedUsecase/base_authenticated_usecase_impl.dart';
import '../../User/UserFetchInfoUsecase/user_fetch_info_usecase.dart';
import '../../User/UserFetchInfoUsecase/user_fetch_info_usecase_impl.dart';
import 'post_fetch_usecase.dart';

part 'post_fetch_usecase_impl.g.dart';

@Riverpod(keepAlive: true)
PostFetchUsecaseImpl postFetchUsecase(
  PostFetchUsecaseRef ref,
) {
  final baseAuthenticatedUsecase = ref.watch(baseAuthenticatedUsecaseProvider);
  final postRepository = ref.watch(postRepositoryProvider);
  final userFetchInfoUsecase = ref.watch(userFetchInfoUsecaseProvider);
  final userRepository = ref.watch(userRepositoryProvider);
  return PostFetchUsecaseImpl(
    baseAuthenticatedUsecase: baseAuthenticatedUsecase,
    postRepository: postRepository,
    userFetchInfoUsecase: userFetchInfoUsecase,
    userRepository: userRepository,
  );
}

class PostFetchUsecaseImpl implements PostFetchUsecase {
  const PostFetchUsecaseImpl({
    required BaseAuthenticatedUsecase baseAuthenticatedUsecase,
    required PostRepository postRepository,
    required UserFetchInfoUsecase userFetchInfoUsecase,
    required UserRepository userRepository,
  })  : _baseAuthenticatedUsecase = baseAuthenticatedUsecase,
        _postRepository = postRepository,
        _userFetchInfoUsecase = userFetchInfoUsecase,
        _userRepository = userRepository;

  final BaseAuthenticatedUsecase _baseAuthenticatedUsecase;
  final PostRepository _postRepository;
  final UserFetchInfoUsecase _userFetchInfoUsecase;
  final UserRepository _userRepository;

  @override
  Stream<List<Post>> streamPostList() async* {
    final postListData = _postRepository.streamPostList();
    await for (final postList in postListData) {
      final updatedPosts = await Future.wait(postList.map((p) async {
        final postUser =
            await _userFetchInfoUsecase.fetchUserInfo(uid: p.ownerUid);
        final didLike = await checkIfPostLiked(postId: p.postId);
        return p.copyWith(user: postUser, didLike: didLike);
      }));
      yield updatedPosts;
    }
  }

  @override
  Future<bool> checkIfPostLiked({required String postId}) async {
    final uid = _baseAuthenticatedUsecase.getCurrentUserId();
    return await _userRepository.checkIfPostLiked(
      currentUserId: uid,
      postId: postId,
    );
  }

  @override
  Future<Post> fetchPost({required String postId}) async {
    return await _postRepository.fetchPost(postId: postId);
  }
}
