import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/Core/Feed/View/feed_cell.dart';
import 'package:instagram_clone/Core/Feed/ViewModel/feed_view_model.dart';
import 'package:instagram_clone/Repository/UserProvider/user_liked_post_provider.dart';

class FavoriteFeedView extends ConsumerWidget {
  final viewModel = FeedViewModel();

  FavoriteFeedView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likedPostStream = ref.watch(userLikedPostProviderProvider);
    return likedPostStream.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('エラー: $error')),
      data: (posts) {
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return FeedCell(post: post, viewModel: viewModel);
          },
        );
      },
    );
  }
}
