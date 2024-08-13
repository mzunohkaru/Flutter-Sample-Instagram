import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Model/Entity/Post/post_comment.dart';
import '../../../Model/Entity/User/user.dart';
import '../../../Repository/PostRepository/PostComment/post_comment_repository.dart';
import '../../../Repository/PostRepository/PostComment/post_comment_repository_impl.dart';
import '../../User/UserFetchInfoUsecase/user_fetch_info_usecase.dart';
import '../../User/UserFetchInfoUsecase/user_fetch_info_usecase_impl.dart';
import 'post_comment_fetch_usecase.dart';

part 'post_comment_fetch_usecase_impl.g.dart';

@Riverpod(keepAlive: true)
PostCommentFetchUsecaseImpl postCommentFetchUsecase(
  PostCommentFetchUsecaseRef ref,
) {
  final postCommentRepository = ref.watch(postCommentRepositoryProvider);
  final userFetchInfoUsecase = ref.watch(userFetchInfoUsecaseProvider);
  return PostCommentFetchUsecaseImpl(
    postCommentRepository: postCommentRepository,
    userFetchInfoUsecase: userFetchInfoUsecase,
  );
}

class PostCommentFetchUsecaseImpl implements PostCommentFetchUsecase {
  const PostCommentFetchUsecaseImpl({
    required PostCommentRepository postCommentRepository,
    required UserFetchInfoUsecase userFetchInfoUsecase,
  })  : _postCommentRepository = postCommentRepository,
        _userFetchInfoUsecase = userFetchInfoUsecase;

  final PostCommentRepository _postCommentRepository;
  final UserFetchInfoUsecase _userFetchInfoUsecase;

  @override
  Stream<List<PostComment>> fetchPostCommentList(
      {required String postId}) async* {
    final postCommentListData =
        _postCommentRepository.streamPostCommentList(postId: postId);
    await for (final postCommentList in postCommentListData) {
      final updatedComments = await Future.wait(
        postCommentList.map((comment) async {
          final user = await fetchCommentOwnerUser(comment.commentOwnerUid);
          return comment.copyWith(user: user);
        }),
      );
      yield updatedComments;
    }
  }

  Future<User> fetchCommentOwnerUser(String uid) async {
    return await _userFetchInfoUsecase.fetchUserInfo(uid: uid);
  }
}
