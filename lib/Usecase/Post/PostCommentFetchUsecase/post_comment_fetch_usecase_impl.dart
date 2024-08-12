import 'package:instagram_clone/Model/Entity/Post/post_comment.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Repository/PostRepository/PostComment/post_comment_repository.dart';
import '../../../Repository/PostRepository/PostComment/post_comment_repository_impl.dart';
import 'post_comment_fetch_usecase.dart';

part 'post_comment_fetch_usecase_impl.g.dart';

@Riverpod(keepAlive: true)
PostCommentFetchUsecaseImpl postCommentFetchUsecase(
  PostCommentFetchUsecaseRef ref,
) {
  final postCommentRepository = ref.watch(postCommentRepositoryProvider);
  return PostCommentFetchUsecaseImpl(
    postCommentRepository: postCommentRepository,
  );
}

class PostCommentFetchUsecaseImpl implements PostCommentFetchUsecase {
  const PostCommentFetchUsecaseImpl({
    required PostCommentRepository postCommentRepository,
  }) : _postCommentRepository = postCommentRepository;

  final PostCommentRepository _postCommentRepository;

  @override
  Stream<List<PostComment>> fetchPostCommentList(
      {required String postId}) async* {
    yield* _postCommentRepository.streamPostCommentList(postId: postId);
  }
}
