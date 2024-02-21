import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/Core/Components/circular_profile_image_view.dart';
import 'package:instagram_clone/Core/Feed/ViewModel/feed_view_model.dart';
import 'package:instagram_clone/Core/Profile/View/profile_view.dart';
import 'package:instagram_clone/Model/Post/post.dart';
import 'package:instagram_clone/Utils/constant.dart';
import 'package:instagram_clone/Widgets/sheet_widget.dart';
import 'package:intl/intl.dart';

class FeedCell extends HookConsumerWidget {
  final Post post;
  final FeedViewModel viewModel;

  const FeedCell({super.key, required this.post, required this.viewModel});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ProfileView(user: post.user!)));
                },
                child: CircularProfileImageView(
                  profileImageUrl: post.user!.profileImageUrl!,
                  radius: 22,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Text(post.user!.username)
            ],
          ),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 360 / 320,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                image: DecorationImage(
                  image: NetworkImage(post.postImageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  if (!post.didLike) {
                    viewModel.like(ref: ref, postId: post.postId);
                  } else {
                    viewModel.unlike(
                      ref: ref,
                      postId: post.postId,
                    );
                  }
                },
                icon: post.didLike
                    ? const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : const Icon(Icons.favorite_border),
              ),
              IconButton(
                onPressed: () {
                  showChatSheet(context: context, post: post);
                },
                icon: const Icon(Icons.chat),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert_outlined),
              ),
            ],
          ),
          post.likes == 0
              ? const SizedBox()
              : Text(
                  "${post.likes} likes",
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w200),
                ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(post.user!.username, style: kUsernameTextStyle),
              const SizedBox(
                width: 3,
              ),
              Text(post.caption)
            ],
          ),
          Text(
            DateFormat('yyyy/MM/dd HH:mm').format(post.createAt.toDate()),
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w200),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
