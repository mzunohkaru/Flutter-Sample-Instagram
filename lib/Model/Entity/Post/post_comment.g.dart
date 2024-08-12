// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PostCommentImpl _$$PostCommentImplFromJson(Map<String, dynamic> json) =>
    _$PostCommentImpl(
      commentId: json['commentId'] as String,
      postId: json['postId'] as String,
      postOwnerUid: json['postOwnerUid'] as String,
      commentOwnerUid: json['commentOwnerUid'] as String,
      commentText: json['commentText'] as String,
      createAt: const TimestampConverter().fromJson(json['createAt']),
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PostCommentImplToJson(_$PostCommentImpl instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'postId': instance.postId,
      'postOwnerUid': instance.postOwnerUid,
      'commentOwnerUid': instance.commentOwnerUid,
      'commentText': instance.commentText,
      'createAt': const TimestampConverter().toJson(instance.createAt),
      'user': instance.user,
    };
