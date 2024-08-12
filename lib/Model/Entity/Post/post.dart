import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instagram_clone/Model/Entity/User/user.dart';
import 'package:instagram_clone/Model/timestamp.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    required String postId,
    required String ownerUid,
    required String caption,
    required List<String> postImageUrls,
    required int likes,
    required List likeUsers,
    required bool didLike,
    @TimestampConverter() required Timestamp createAt,
    required User? user
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}

