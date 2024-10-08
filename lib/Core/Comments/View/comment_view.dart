import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../Model/Entity/Post/post.dart';
import '../../../State/Post/PostCommentState/post_comment_controller.dart';
import '../../../Utils/constant.dart';
import '../../../Utils/format_date.dart';
import '../../Components/circular_profile_image_view.dart';
import '../ViewModel/comment_view_model.dart';

class CommentView extends HookConsumerWidget {
  final Post post;
  final viewModel = CommentViewModel();
  CommentView({super.key, required this.post});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentStream =
        ref.watch(PostCommentControllerProvider(postId: post.postId));

    final commentController = useTextEditingController();
    final isValidation = useState(false);

    useEffect(() {
      void listener() {
        isValidation.value = commentController.text.isNotEmpty;
      }

      commentController.addListener(listener);
      return () {
        commentController.removeListener(listener);
      };
    }, [commentController]);

    void reset() {
      commentController.clear();
      FocusScope.of(context).unfocus();
    }

    return SizedBox(
      height: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Expanded(
            child: commentStream.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('エラー: $error')),
              data: (comments) {
                if (comments.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.post_add,
                          size: 80,
                        ),
                        Text(
                          "No Comments",
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Let me make my first comment.",
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w200),
                        ),
                      ],
                    ),
                  );
                } else {
                  // コメントを時間順にソート
                  final sortedComments = comments.toList()
                    ..sort((a, b) => b.createAt.compareTo(a.createAt));

                  return ListView.builder(
                    reverse: true,
                    itemCount: sortedComments.length,
                    itemBuilder: (context, index) {
                      final comment = sortedComments[index];

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 8.0),
                        child: Row(
                          children: [
                            CircularProfileImageView(
                                profileImageUrl: comment.user!.profileImageUrl,
                                radius: 22),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  comment.user!.username,
                                  style: kUsernameTextStyle,
                                ),
                                Text(comment.commentText),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              // DateFormat('MM/dd HH:mm')
                              //     .format(comment.createAt.toDate()),
                              formatDate(comment.createAt),
                              style: kSubTextStyle,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: commentController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none),
                      filled: true,
                      labelText: "Comment..",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.send,
                    color: isValidation.value ? Colors.blue : Colors.grey,
                  ),
                  onPressed: isValidation.value
                      ? () async {
                          await viewModel.comment(
                              ref: ref,
                              postId: post.postId,
                              commentText: commentController.text);
                          reset();
                        }
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
