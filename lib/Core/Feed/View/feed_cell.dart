import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/Core/Components/circular_profile_image_view.dart';
import 'package:instagram_clone/Core/Feed/ViewModel/feed_view_model.dart';
import 'package:instagram_clone/Core/Profile/View/profile_view.dart';
import 'package:instagram_clone/Model/Entity/Post/post.dart';
import 'package:instagram_clone/Utils/constant.dart';
import 'package:instagram_clone/Utils/format_date.dart';
import 'package:instagram_clone/Widgets/sheet_widget.dart';

class FeedCell extends HookConsumerWidget {
  final Post post;
  final FeedViewModel viewModel;

  FeedCell({super.key, required this.post, required this.viewModel});

  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentCarouselPosition = useState(0);

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
          post.postImageUrls.length == 1
              ? AspectRatio(
                  aspectRatio: 360 / 320,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      image: DecorationImage(
                        image: NetworkImage(post.postImageUrls[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              : Column(
                  children: [
                    CarouselSlider(
                      carouselController: controller,
                      options: CarouselOptions(
                        aspectRatio: 360 / 320,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          currentCarouselPosition.value = index;
                        },
                      ),
                      items: post.postImageUrls.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 3.0),
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                  image: NetworkImage(i),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: post.postImageUrls.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => controller.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: currentCarouselPosition.value == entry.key
                                  ? Colors.blueAccent
                                  : Colors.grey,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
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
                  style: kSubTextStyle,
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
            // DateFormat('yyyy/MM/dd HH:mm').format(post.createAt.toDate()),
            formatDate(post.createAt),
            style: kSubTextStyle,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
