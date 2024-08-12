import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../Model/User/user.dart';
import '../../../Usecase/Auth/BaseAuthenticatedUsecase/base_authenticated_usecase_impl.dart';
import '../../../Utils/constant.dart';
import '../../../Widgets/dialog_widget.dart';
import '../../Components/circular_profile_image_view.dart';
import '../../Components/no_posts_view.dart';
import '../ViewModel/profile_view_model.dart';
import 'edit_profile_view.dart';

class ProfileView extends HookConsumerWidget {
  final User user;
  final viewModel = ProfileViewModel();

  ProfileView({super.key, required this.user});

  final CarouselController controller = CarouselController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserUid =
        ref.read(baseAuthenticatedUsecaseProvider).getCurrentUserId();

    final follow = useState<bool?>(null);

    useEffect(() {
      void checkFollowStatus() async {
        final isFollowing =
            await viewModel.checkIfUserFollowed(uid: user.userId);
        follow.value = isFollowing;
      }

      checkFollowStatus();
      return null;
    }, [user.userId]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Profile",
          style: kAppBarTitleTextStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: FutureBuilder(
          future: viewModel.fetchUser(userId: user.userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final user = snapshot.data;

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircularProfileImageView(
                          profileImageUrl: user!.profileImageUrl,
                          radius: 44,
                        ),
                        const SizedBox(
                          width: 80,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 40, // ListViewに高さを指定
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: ProfileStats.values.length,
                              itemBuilder: (BuildContext context, int index) {
                                final stat = ProfileStats.values[index];
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    children: [
                                      Text("${getStatValue(stat, user)}"),
                                      Text(getStatTitle(stat)),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(user.username, style: kUsernameTextStyle),
                          Text(user.bio ?? "")
                        ],
                      ),
                    ),
                    if (follow.value != null)
                      // Edit Button
                      currentUserUid == user.userId
                          ? SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.black,
                                    elevation: 2,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                          builder: (context) => EditProfileView(
                                              initialUsername: user.username,
                                              initialBio: user.bio ?? "")),
                                    );
                                  },
                                  child: const Text("Edit Profile")),
                            )
                          // Follow Button
                          : SizedBox(
                              width: double.infinity,
                              height: 40,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: follow.value!
                                      ? Colors.white
                                      : Colors.black,
                                  foregroundColor: follow.value!
                                      ? Colors.black
                                      : Colors.white,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () async {
                                  if (!follow.value!) {
                                    await viewModel.follow(
                                        ref: ref, uid: user.userId);
                                    follow.value = true;
                                  } else {
                                    await viewModel.unfollow(
                                        ref: ref, uid: user.userId);
                                    follow.value = false;
                                  }
                                },
                                child: follow.value!
                                    ? const Text("Following")
                                    : const Text("Follow"),
                              ),
                            ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Divider(),
                    user.post!.isNotEmpty
                        ? Flexible(
                            child: GridView.builder(
                              itemCount: user.post!.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 1.0,
                                mainAxisSpacing: 1.0,
                                childAspectRatio: 0.7,
                              ),
                              itemBuilder: (context, index) {
                                final userPost = user.post![index];
                                return GestureDetector(
                                  onTap: () {
                                    showPostDialog(
                                        context: context,
                                        postImageUrl:
                                            userPost.postImageUrls[0]); // 改
                                  },
                                  child: CarouselSlider(
                                    carouselController: controller,
                                    options: CarouselOptions(
                                      aspectRatio: 360 / 320,
                                      viewportFraction: 1.0,
                                      enableInfiniteScroll: false,
                                    ),
                                    items: userPost.postImageUrls.map((i) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 3.0),
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
                                );
                              },
                            ),
                          )
                        : const NoPostsView()
                  ],
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              }
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

enum ProfileStats { followers, following, likes }

String getStatTitle(ProfileStats stat) {
  switch (stat) {
    case ProfileStats.followers:
      return "Followers";
    case ProfileStats.following:
      return "Following";
    case ProfileStats.likes:
      return "Likes";
    default:
      return "";
  }
}

int getStatValue(ProfileStats stat, dynamic user) {
  switch (stat) {
    case ProfileStats.followers:
      return user.followers;
    case ProfileStats.following:
      return user.following;
    case ProfileStats.likes:
      return user.likes;
    default:
      return 0;
  }
}
