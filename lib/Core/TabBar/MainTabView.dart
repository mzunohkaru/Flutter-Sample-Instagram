import 'package:flutter/material.dart';
import 'package:instagram_clone/Core/FavoriteFeed/View/favorite_feed_view.dart';
import 'package:instagram_clone/Core/Feed/View/feed_view.dart';
import 'package:instagram_clone/Core/Explore/View/explore_view.dart';
import 'package:instagram_clone/Core/Profile/View/current_profile_view.dart';
import 'package:instagram_clone/Core/UploadPost/View/upload_post_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  _MainTabViewState createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  int _selectedIndex = 0;
  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = [
      FeedView(),
      const ExploreView(),
      UploadPostView(resetAndNavigateToFeed: resetAndNavigateToFeed),
      FavoriteFeedView(),
      CurrentProfileView(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          )
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  void resetAndNavigateToFeed() {
    setState(() {
      _selectedIndex = 0; // FeedViewへのインデックス
    });
  }
}
