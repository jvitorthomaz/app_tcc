// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_schedules_history_vm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userSchedulesHistoryVmHash() =>
    r'3f92ec6df9bcb8609c85f8c81a6c276b28739c9f';

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

abstract class _$UserSchedulesHistoryVm
    extends BuildlessAutoDisposeAsyncNotifier<List<SchedulesModel>> {
  late final int userId;

  FutureOr<List<SchedulesModel>> build(
    int userId,
  );
}

/// See also [UserSchedulesHistoryVm].
@ProviderFor(UserSchedulesHistoryVm)
const userSchedulesHistoryVmProvider = UserSchedulesHistoryVmFamily();

/// See also [UserSchedulesHistoryVm].
class UserSchedulesHistoryVmFamily
    extends Family<AsyncValue<List<SchedulesModel>>> {
  /// See also [UserSchedulesHistoryVm].
  const UserSchedulesHistoryVmFamily();

  /// See also [UserSchedulesHistoryVm].
  UserSchedulesHistoryVmProvider call(
    int userId,
  ) {
    return UserSchedulesHistoryVmProvider(
      userId,
    );
  }

  @override
  UserSchedulesHistoryVmProvider getProviderOverride(
    covariant UserSchedulesHistoryVmProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'userSchedulesHistoryVmProvider';
}

/// See also [UserSchedulesHistoryVm].
class UserSchedulesHistoryVmProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserSchedulesHistoryVm,
        List<SchedulesModel>> {
  /// See also [UserSchedulesHistoryVm].
  UserSchedulesHistoryVmProvider(
    int userId,
  ) : this._internal(
          () => UserSchedulesHistoryVm()..userId = userId,
          from: userSchedulesHistoryVmProvider,
          name: r'userSchedulesHistoryVmProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userSchedulesHistoryVmHash,
          dependencies: UserSchedulesHistoryVmFamily._dependencies,
          allTransitiveDependencies:
              UserSchedulesHistoryVmFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserSchedulesHistoryVmProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final int userId;

  @override
  FutureOr<List<SchedulesModel>> runNotifierBuild(
    covariant UserSchedulesHistoryVm notifier,
  ) {
    return notifier.build(
      userId,
    );
  }

  @override
  Override overrideWith(UserSchedulesHistoryVm Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserSchedulesHistoryVmProvider._internal(
        () => create()..userId = userId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<UserSchedulesHistoryVm,
      List<SchedulesModel>> createElement() {
    return _UserSchedulesHistoryVmProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserSchedulesHistoryVmProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UserSchedulesHistoryVmRef
    on AutoDisposeAsyncNotifierProviderRef<List<SchedulesModel>> {
  /// The parameter `userId` of this provider.
  int get userId;
}

class _UserSchedulesHistoryVmProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserSchedulesHistoryVm,
        List<SchedulesModel>> with UserSchedulesHistoryVmRef {
  _UserSchedulesHistoryVmProviderElement(super.provider);

  @override
  int get userId => (origin as UserSchedulesHistoryVmProvider).userId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
