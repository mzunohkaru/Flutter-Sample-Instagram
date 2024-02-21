// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      userId: json['userId'] as String,
      username: json['username'] as String,
      bio: json['bio'] as String?,
      profileImageUrl: json['profileImageUrl'] as String?,
      followers: json['followers'] as int,
      following: json['following'] as int,
      likes: json['likes'] as int,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'bio': instance.bio,
      'profileImageUrl': instance.profileImageUrl,
      'followers': instance.followers,
      'following': instance.following,
      'likes': instance.likes,
    };
