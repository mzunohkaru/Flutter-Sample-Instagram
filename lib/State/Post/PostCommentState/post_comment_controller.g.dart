// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postCommentControllerHash() =>
    r'e81a22674f594be8ad4bf2774b543d6bb0eb40e2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$PostCommentController
    extends BuildlessAutoDisposeStreamNotifier<List<PostComment>> {
  late final String postId;

  Stream<List<PostComment>> build({
    required String postId,
  });
}

/// See also [PostCommentController].
@ProviderFor(PostCommentController)
const postCommentControllerProvider = PostCommentControllerFamily();

/// See also [PostCommentController].
class PostCommentControllerFamily
    extends Family<AsyncValue<List<PostComment>>> {
  /// See also [PostCommentController].
  const PostCommentControllerFamily();

  /// See also [PostCommentController].
  PostCommentControllerProvider call({
    required String postId,
  }) {
    return PostCommentControllerProvider(
      postId: postId,
    );
  }

  @override
  PostCommentControllerProvider getProviderOverride(
    covariant PostCommentControllerProvider provider,
  ) {
    return call(
      postId: provider.postId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'postCommentControllerProvider';
}

/// See also [PostCommentController].
class PostCommentControllerProvider
    extends AutoDisposeStreamNotifierProviderImpl<PostCommentController,
        List<PostComment>> {
  /// See also [PostCommentController].
  PostCommentControllerProvider({
    required String postId,
  }) : this._internal(
          () => PostCommentController()..postId = postId,
          from: postCommentControllerProvider,
          name: r'postCommentControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postCommentControllerHash,
          dependencies: PostCommentControllerFamily._dependencies,
          allTransitiveDependencies:
              PostCommentControllerFamily._allTransitiveDependencies,
          postId: postId,
        );

  PostCommentControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final String postId;

  @override
  Stream<List<PostComment>> runNotifierBuild(
    covariant PostCommentController notifier,
  ) {
    return notifier.build(
      postId: postId,
    );
  }

  @override
  Override overrideWith(PostCommentController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostCommentControllerProvider._internal(
        () => create()..postId = postId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        postId: postId,
      ),
    );
  }

  @override
  AutoDisposeStreamNotifierProviderElement<PostCommentController,
      List<PostComment>> createElement() {
    return _PostCommentControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostCommentControllerProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostCommentControllerRef
    on AutoDisposeStreamNotifierProviderRef<List<PostComment>> {
  /// The parameter `postId` of this provider.
  String get postId;
}

class _PostCommentControllerProviderElement
    extends AutoDisposeStreamNotifierProviderElement<PostCommentController,
        List<PostComment>> with PostCommentControllerRef {
  _PostCommentControllerProviderElement(super.provider);

  @override
  String get postId => (origin as PostCommentControllerProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
