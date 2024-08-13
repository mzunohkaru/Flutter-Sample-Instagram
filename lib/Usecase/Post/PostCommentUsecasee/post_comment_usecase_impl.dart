import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Repository/PostRepository/PostComment/post_comment_repository.dart';
import '../../../Repository/PostRepository/PostComment/post_comment_repository_impl.dart';
import '../../Auth/BaseAuthenticatedUsecase/base_authenticated_usecase.dart';
import '../../Auth/BaseAuthenticatedUsecase/base_authenticated_usecase_impl.dart';
import 'post_comment_usecase.dart';

part 'post_comment_usecase_impl.g.dart';

@Riverpod(keepAlive: true)
PostCommentUsecaseImpl postCommentUsecase(
  PostCommentUsecaseRef ref,
) {
  final postCommentRepository = ref.watch(postCommentRepositoryProvider);
  final baseAuthenticatedUsecase = ref.watch(baseAuthenticatedUsecaseProvider);
  return PostCommentUsecaseImpl(
    postCommentRepository: postCommentRepository,
    baseAuthenticatedUsecase: baseAuthenticatedUsecase,
  );
}

class PostCommentUsecaseImpl implements PostCommentUsecase {
  const PostCommentUsecaseImpl({
    required PostCommentRepository postCommentRepository,
    required BaseAuthenticatedUsecase baseAuthenticatedUsecase,
  })  : _postCommentRepository = postCommentRepository,
        _baseAuthenticatedUsecase = baseAuthenticatedUsecase;

  final PostCommentRepository _postCommentRepository;
  final BaseAuthenticatedUsecase _baseAuthenticatedUsecase;

  @override
  Future comment({required String postId, required String commentText}) {
    final currentUserId = _baseAuthenticatedUsecase.getCurrentUserId();
    return _postCommentRepository.comment(
      postId: postId,
      commentText: commentText,
      currentUid: currentUserId,
    );
  }
}
