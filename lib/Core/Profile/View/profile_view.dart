import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:instagram_clone/Core/Components/circular_profile_image_view.dart';
import 'package:instagram_clone/Core/Profile/ViewModel/profile_view_model.dart';
import 'package:instagram_clone/Model/User/user.dart';
import 'package:instagram_clone/Utils/constant.dart';

class ProfileView extends HookConsumerWidget {
  final User user;
  final viewModel = ProfileViewModel();

  ProfileView({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircularProfileImageView(
                  profileImageUrl: user.profileImageUrl,
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        follow.value! ? Colors.white : Colors.black,
                    foregroundColor:
                        follow.value! ? Colors.black : Colors.white,
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {
                    if (!follow.value!) {
                      await viewModel.follow(ref: ref, uid: user.userId);
                      follow.value = true;
                    } else {
                      await viewModel.unfollow(ref: ref, uid: user.userId);
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
          ],
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
