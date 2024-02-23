import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instagram_clone/Model/Post/post.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String userId,
    required String username,
    required String? bio,
    required String? profileImageUrl,
    required int followers,
    required int following,
    required int likes,
    required List<Post>? post,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}