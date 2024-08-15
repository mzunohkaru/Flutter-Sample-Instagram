import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Model/Entity/Post/post.dart';
import '../../../Repository/PostRepository/Post/post_repository.dart';
import '../../../Repository/PostRepository/Post/post_repository_impl.dart';
import '../../Auth/BaseAuthenticatedUsecase/base_authenticated_usecase.dart';
import '../../Auth/BaseAuthenticatedUsecase/base_authenticated_usecase_impl.dart';
import 'post_upload_usecase.dart';

part 'post_upload_usecase_impl.g.dart';

@Riverpod(keepAlive: true)
PostUploadUsecaseImpl postUploadUsecase(
  PostUploadUsecaseRef ref,
) {
  final baseAuthenticatedUsecase = ref.watch(baseAuthenticatedUsecaseProvider);
  final postRepository = ref.watch(postRepositoryProvider);
  return PostUploadUsecaseImpl(
    baseAuthenticatedUsecase: baseAuthenticatedUsecase,
    postRepository: postRepository,
  );
}

class PostUploadUsecaseImpl implements PostUploadUsecase {
  const PostUploadUsecaseImpl({
    required BaseAuthenticatedUsecase baseAuthenticatedUsecase,
    required PostRepository postRepository,
  })  : _baseAuthenticatedUsecase = baseAuthenticatedUsecase,
        _postRepository = postRepository;

  final BaseAuthenticatedUsecase _baseAuthenticatedUsecase;
  final PostRepository _postRepository;

  @override
  Future<void> uploadPost(
      {required String postId,
      required String caption,
      required List<String> postImageUrls}) async {
    try {
      final currentUid = _baseAuthenticatedUsecase.getCurrentUserId();

      final postData = Post(
        postId: postId,
        ownerUid: currentUid,
        caption: caption,
        postImageUrls: postImageUrls,
        likes: 0,
        likeUsers: [],
        didLike: false,
        createAt: Timestamp.now(),
        user: null,
      );

      await _postRepository.createPost(post: postData);
    } catch (e) {
      throw Exception(e);
    }
  }
}
