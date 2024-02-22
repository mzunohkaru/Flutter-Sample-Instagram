// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_comment_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$postCommentProviderHash() =>
    r'643661dcea5c2771f44740b14e1c640e3ee9184b';

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

abstract class _$PostCommentProvider
    extends BuildlessAutoDisposeStreamNotifier<List<Comment>> {
  late final dynamic postId;

  Stream<List<Comment>> build(
    dynamic postId,
  );
}

/// See also [PostCommentProvider].
@ProviderFor(PostCommentProvider)
const postCommentProviderProvider = PostCommentProviderFamily();

/// See also [PostCommentProvider].
class PostCommentProviderFamily extends Family<AsyncValue<List<Comment>>> {
  /// See also [PostCommentProvider].
  const PostCommentProviderFamily();

  /// See also [PostCommentProvider].
  PostCommentProviderProvider call(
    dynamic postId,
  ) {
    return PostCommentProviderProvider(
      postId,
    );
  }

  @override
  PostCommentProviderProvider getProviderOverride(
    covariant PostCommentProviderProvider provider,
  ) {
    return call(
      provider.postId,
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
  String? get name => r'postCommentProviderProvider';
}

/// See also [PostCommentProvider].
class PostCommentProviderProvider extends AutoDisposeStreamNotifierProviderImpl<
    PostCommentProvider, List<Comment>> {
  /// See also [PostCommentProvider].
  PostCommentProviderProvider(
    dynamic postId,
  ) : this._internal(
          () => PostCommentProvider()..postId = postId,
          from: postCommentProviderProvider,
          name: r'postCommentProviderProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$postCommentProviderHash,
          dependencies: PostCommentProviderFamily._dependencies,
          allTransitiveDependencies:
              PostCommentProviderFamily._allTransitiveDependencies,
          postId: postId,
        );

  PostCommentProviderProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.postId,
  }) : super.internal();

  final dynamic postId;

  @override
  Stream<List<Comment>> runNotifierBuild(
    covariant PostCommentProvider notifier,
  ) {
    return notifier.build(
      postId,
    );
  }

  @override
  Override overrideWith(PostCommentProvider Function() create) {
    return ProviderOverride(
      origin: this,
      override: PostCommentProviderProvider._internal(
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
  AutoDisposeStreamNotifierProviderElement<PostCommentProvider, List<Comment>>
      createElement() {
    return _PostCommentProviderProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PostCommentProviderProvider && other.postId == postId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, postId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin PostCommentProviderRef
    on AutoDisposeStreamNotifierProviderRef<List<Comment>> {
  /// The parameter `postId` of this provider.
  dynamic get postId;
}

class _PostCommentProviderProviderElement
    extends AutoDisposeStreamNotifierProviderElement<PostCommentProvider,
        List<Comment>> with PostCommentProviderRef {
  _PostCommentProviderProviderElement(super.provider);

  @override
  dynamic get postId => (origin as PostCommentProviderProvider).postId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
