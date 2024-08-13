import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Model/Entity/Post/post_comment.dart';
import '../../../Usecase/Post/PostCommentFetchUsecase/post_comment_fetch_usecase.dart';
import '../../../Usecase/Post/PostCommentFetchUsecase/post_comment_fetch_usecase_impl.dart';

part 'post_comment_controller.g.dart';

@riverpod
class PostCommentController extends _$PostCommentController {
  late final PostCommentFetchUsecase _postCommentFetchUsecase;
  @override
  Stream<List<PostComment>> build({required String postId}) async* {
    _postCommentFetchUsecase = ref.read(postCommentFetchUsecaseProvider);
    yield* _postCommentFetchUsecase.fetchPostCommentList(postId: postId);
  }
}
