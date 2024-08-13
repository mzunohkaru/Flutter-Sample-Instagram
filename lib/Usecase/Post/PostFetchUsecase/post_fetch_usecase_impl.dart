import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Model/Entity/Post/post.dart';
import '../../../Repository/PostRepository/Post/post_repository.dart';
import '../../../Repository/PostRepository/Post/post_repository_impl.dart';
import 'post_fetch_usecase.dart';

part 'post_fetch_usecase_impl.g.dart';

@Riverpod(keepAlive: true)
PostFetchUsecaseImpl postFetchUsecase(
  PostFetchUsecaseRef ref,
) {
  final postRepository = ref.watch(postRepositoryProvider);
  return PostFetchUsecaseImpl(
    postRepository: postRepository,
  );
}

class PostFetchUsecaseImpl implements PostFetchUsecase {
  const PostFetchUsecaseImpl({
    required PostRepository postRepository,
  }) : _postRepository = postRepository;

  final PostRepository _postRepository;

  @override
  Future<Post> fetchPost({required String postId}) async {
    return await _postRepository.fetchPost(postId: postId);
  }
}
