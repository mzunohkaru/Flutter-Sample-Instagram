import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Core/Feed/View/feed_cell.dart';
import 'package:instagram_clone/Core/Feed/ViewModel/feed_view_model.dart';
import 'package:instagram_clone/Repository/post_provider.dart';

class FeedView extends ConsumerWidget {
  final viewModel = FeedViewModel();

  FeedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postStream = ref.watch(postStreamProvider);
    return postStream.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('エラー: $error')),
      data: (posts) {
        if (posts.isEmpty) {
          return const Center(
            child: Text(
              "No Posts",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
