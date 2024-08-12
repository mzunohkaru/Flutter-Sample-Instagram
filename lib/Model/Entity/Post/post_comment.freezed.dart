// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_comment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PostComment _$PostCommentFromJson(Map<String, dynamic> json) {
  return _PostComment.fromJson(json);
}

/// @nodoc
mixin _$PostComment {
  String get commentId => throw _privateConstructorUsedError;
  String get postId => throw _privateConstructorUsedError;
  String get postOwnerUid => throw _privateConstructorUsedError;
  String get commentOwnerUid => throw _privateConstructorUsedError;
  String get commentText => throw _privateConstructorUsedError;
  @TimestampConverter()
  Timestamp get createAt => throw _privateConstructorUsedError;
  User? get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostCommentCopyWith<PostComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostCommentCopyWith<$Res> {
  factory $PostCommentCopyWith(
          PostComment value, $Res Function(PostComment) then) =
      _$PostCommentCopyWithImpl<$Res, PostComment>;
  @useResult
  $Res call(
      {String commentId,
      String postId,
      String postOwnerUid,
      String commentOwnerUid,
      String commentText,
      @TimestampConverter() Timestamp createAt,
      User? user});

  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class _$PostCommentCopyWithImpl<$Res, $Val extends PostComment>
    implements $PostCommentCopyWith<$Res> {
  _$PostCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
    Object? postId = null,
    Object? postOwnerUid = null,
    Object? commentOwnerUid = null,
    Object? commentText = null,
    Object? createAt = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      commentId: null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      postOwnerUid: null == postOwnerUid
          ? _value.postOwnerUid
          : postOwnerUid // ignore: cast_nullable_to_non_nullable
              as String,
      commentOwnerUid: null == commentOwnerUid
          ? _value.commentOwnerUid
          : commentOwnerUid // ignore: cast_nullable_to_non_nullable
              as String,
      commentText: null == commentText
          ? _value.commentText
          : commentText // ignore: cast_nullable_to_non_nullable
              as String,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PostCommentImplCopyWith<$Res>
    implements $PostCommentCopyWith<$Res> {
  factory _$$PostCommentImplCopyWith(
          _$PostCommentImpl value, $Res Function(_$PostCommentImpl) then) =
      __$$PostCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String commentId,
      String postId,
      String postOwnerUid,
      String commentOwnerUid,
      String commentText,
      @TimestampConverter() Timestamp createAt,
      User? user});

  @override
  $UserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$PostCommentImplCopyWithImpl<$Res>
    extends _$PostCommentCopyWithImpl<$Res, _$PostCommentImpl>
    implements _$$PostCommentImplCopyWith<$Res> {
  __$$PostCommentImplCopyWithImpl(
      _$PostCommentImpl _value, $Res Function(_$PostCommentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? commentId = null,
    Object? postId = null,
    Object? postOwnerUid = null,
    Object? commentOwnerUid = null,
    Object? commentText = null,
    Object? createAt = null,
    Object? user = freezed,
  }) {
    return _then(_$PostCommentImpl(
      commentId: null == commentId
          ? _value.commentId
          : commentId // ignore: cast_nullable_to_non_nullable
              as String,
      postId: null == postId
          ? _value.postId
          : postId // ignore: cast_nullable_to_non_nullable
              as String,
      postOwnerUid: null == postOwnerUid
          ? _value.postOwnerUid
          : postOwnerUid // ignore: cast_nullable_to_non_nullable
              as String,
      commentOwnerUid: null == commentOwnerUid
          ? _value.commentOwnerUid
          : commentOwnerUid // ignore: cast_nullable_to_non_nullable
              as String,
      commentText: null == commentText
          ? _value.commentText
          : commentText // ignore: cast_nullable_to_non_nullable
              as String,
      createAt: null == createAt
          ? _value.createAt
          : createAt // ignore: cast_nullable_to_non_nullable
              as Timestamp,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PostCommentImpl implements _PostComment {
  const _$PostCommentImpl(
      {required this.commentId,
      required this.postId,
      required this.postOwnerUid,
      required this.commentOwnerUid,
      required this.commentText,
      @TimestampConverter() required this.createAt,
      required this.user});

  factory _$PostCommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$PostCommentImplFromJson(json);

  @override
  final String commentId;
  @override
  final String postId;
  @override
  final String postOwnerUid;
  @override
  final String commentOwnerUid;
  @override
  final String commentText;
  @override
  @TimestampConverter()
  final Timestamp createAt;
  @override
  final User? user;

  @override
  String toString() {
    return 'PostComment(commentId: $commentId, postId: $postId, postOwnerUid: $postOwnerUid, commentOwnerUid: $commentOwnerUid, commentText: $commentText, createAt: $createAt, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PostCommentImpl &&
            (identical(other.commentId, commentId) ||
                other.commentId == commentId) &&
            (identical(other.postId, postId) || other.postId == postId) &&
            (identical(other.postOwnerUid, postOwnerUid) ||
                other.postOwnerUid == postOwnerUid) &&
            (identical(other.commentOwnerUid, commentOwnerUid) ||
                other.commentOwnerUid == commentOwnerUid) &&
            (identical(other.commentText, commentText) ||
                other.commentText == commentText) &&
            (identical(other.createAt, createAt) ||
                other.createAt == createAt) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, commentId, postId, postOwnerUid,
      commentOwnerUid, commentText, createAt, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PostCommentImplCopyWith<_$PostCommentImpl> get copyWith =>
      __$$PostCommentImplCopyWithImpl<_$PostCommentImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PostCommentImplToJson(
      this,
    );
  }
}

abstract class _PostComment implements PostComment {
  const factory _PostComment(
      {required final String commentId,
      required final String postId,
      required final String postOwnerUid,
      required final String commentOwnerUid,
      required final String commentText,
      @TimestampConverter() required final Timestamp createAt,
      required final User? user}) = _$PostCommentImpl;

  factory _PostComment.fromJson(Map<String, dynamic> json) =
      _$PostCommentImpl.fromJson;

  @override
  String get commentId;
  @override
  String get postId;
  @override
  String get postOwnerUid;
  @override
  String get commentOwnerUid;
  @override
  String get commentText;
  @override
  @TimestampConverter()
  Timestamp get createAt;
  @override
  User? get user;
  @override
  @JsonKey(ignore: true)
  _$$PostCommentImplCopyWith<_$PostCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
