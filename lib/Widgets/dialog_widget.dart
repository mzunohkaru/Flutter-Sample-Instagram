import 'package:flutter/material.dart';

void showAuthErrorDialog(
    {required BuildContext context,
    required String title,
    required String content}) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: const Text("閉じる"),
            onPressed: () => Navigator.of(dialogContext).pop(),
          ),
        ],
      );
    },
  );
}

void showPostDialog(
    {required BuildContext context, required String postImageUrl}) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return Dialog(
        child: Image.network(
          postImageUrl,
          fit: BoxFit.cover,
        ),
      );
    },
  );
}
