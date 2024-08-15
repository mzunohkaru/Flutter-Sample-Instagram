import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../Model/Entity/Post/post.dart';
import '../../../Usecase/Post/PostFetchUsecase/post_fetch_usecase.dart';
import '../../../Usecase/Post/PostFetchUsecase/post_fetch_usecase_impl.dart';

part 'post_fetch_controller.g.dart';

@riverpod
class PostFetchController extends _$PostFetchController {
  late final PostFetchUsecase _postFetchUsecase;

  @override
  Stream<List<Post>> build() async* {
    _postFetchUsecase = ref.read(postFetchUsecaseProvider);
    yield* _postFetchUsecase.streamPostList();
  }
}
