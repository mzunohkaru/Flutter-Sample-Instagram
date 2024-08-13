import 'package:flutter/material.dart';

import '../Core/Comments/View/comment_view.dart';
import '../Model/Entity/Post/post.dart';

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
