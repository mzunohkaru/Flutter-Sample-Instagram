import 'package:flutter/material.dart';
import 'package:instagram_clone/Core/Comments/View/comment_view.dart';
import 'package:instagram_clone/Model/Post/post.dart';

void showChatSheet({
  required BuildContext context,
  required Post post
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // スクロール可能にする
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.9, // 画面の90%の高さを使用
        child: CommentView(post: post),
      );
    },
  );
}
