import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../State/Post/PostFetchState/post_fetch_controller.dart';
import '../ViewModel/feed_view_model.dart';
import 'feed_cell.dart';

class FeedView extends ConsumerWidget {
  final viewModel = FeedViewModel();

  FeedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postStream = ref.watch(postFetchControllerProvider);

    return postStream.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('エラー: $error')),
      data: (posts) {
        if (posts.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.post_add,
                  size: 80,
                ),
                Text(
                  "No Posts",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Text(
                  "New posts you receive will appear here.",
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w200),
                ),
              ],
            ),
          );
        } else {
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return FeedCell(post: post, viewModel: viewModel);
            },
          );
        }
      },
    );
  }
}
