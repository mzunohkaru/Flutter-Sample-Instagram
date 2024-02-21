import 'package:flutter/material.dart';
import 'package:instagram_clone/Core/Auth/View/login_view.dart';
import 'package:instagram_clone/Core/Root/ViewModel/splash_view_model.dart';
import 'package:instagram_clone/Core/TabBar/MainTabView.dart';
import 'package:instagram_clone/Utils/constant.dart';

/// ログイン状態に応じてユーザーをリダイレクトするページ
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  SplashViewState createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  final viewModel = SplashViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.setupSubscribers().then((isCurrentUserSession) {
      if (isCurrentUserSession) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const MainTabView(),
          ),
        );
      } else {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => LoginView(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: preloader);
  }
}
