import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/Core/Auth/Service/auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/Services/post_service.dart';
import 'package:instagram_clone/Services/uploader.dart';
import 'package:instagram_clone/Services/user_service.dart';
import 'package:logger/logger.dart';

final authService = AuthService.instance;

final auth = FirebaseAuth.instance;
final firestore = FirebaseFirestore.instance;
final storage = FirebaseStorage.instance;

final UserCollections = firestore.collection('users');
final PostCollections = firestore.collection('posts');

final FollowingCollections = firestore.collection("following");
final FollowerCollections = firestore.collection("followers");

final userService = UserService();
final postService = PostService();
final uploader = Uploader();

/// シンプルなプリローダー
const preloader = Center(child: CircularProgressIndicator());

/// user name スタイルテキストの定数
const TextStyle kUsernameTextStyle = TextStyle(
  fontWeight: FontWeight.w600,
);

/// user name スタイルテキストの定数
const TextStyle kSubTextStyle = TextStyle(
  fontWeight: FontWeight.w200,
  color: Colors.grey,
  fontSize: 12,
);

/// AppBar スタイルテキストの定数
const TextStyle kAppBarTitleTextStyle = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

final logger = Logger();
