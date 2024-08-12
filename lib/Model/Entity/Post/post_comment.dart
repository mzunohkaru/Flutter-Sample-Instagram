import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:instagram_clone/Model/Entity/User/user.dart';
import 'package:instagram_clone/Model/timestamp.dart';

part 'post_comment.freezed.dart';
part 'post_comment.g.dart';

@freezed
class PostComment with _$PostComment {
  const factory PostComment({
    required String commentId,
    required String postId,
    required String postOwnerUid,
    required String commentOwnerUid,
    required String commentText,
    @TimestampConverter() required Timestamp createAt,
    required User? user
  }) = _PostComment;

  factory PostComment.fromJson(Map<String, dynamic> json) => _$PostCommentFromJson(json);
}

