// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_schedules_vm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$employeeSchedulesVmHash() =>
    r'dd090bafd4d5166ca37d301767a9cb3cc8e2c30d';

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

abstract class _$EmployeeSchedulesVm
    extends BuildlessAutoDisposeAsyncNotifier<List<SchedulesModel>> {
  late final int userId;
  late final DateTime date;

  FutureOr<List<SchedulesModel>> build(
    int userId,
    DateTime date,
  );
}

/// See also [EmployeeSchedulesVm].
@ProviderFor(EmployeeSchedulesVm)
const employeeSchedulesVmProvider = EmployeeSchedulesVmFamily();

/// See also [EmployeeSchedulesVm].
class EmployeeSchedulesVmFamily
    extends Family<AsyncValue<List<SchedulesModel>>> {
  /// See also [EmployeeSchedulesVm].
  const EmployeeSchedulesVmFamily();

  /// See also [EmployeeSchedulesVm].
  EmployeeSchedulesVmProvider call(
    int userId,
    DateTime date,
  ) {
    return EmployeeSchedulesVmProvider(
      userId,
      date,
    );
  }

  @override
  EmployeeSchedulesVmProvider getProviderOverride(
    covariant EmployeeSchedulesVmProvider provider,
  ) {
    return call(
      provider.userId,
      provider.date,
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
  String? get name => r'employeeSchedulesVmProvider';
}

/// See also [EmployeeSchedulesVm].
class EmployeeSchedulesVmProvider extends AutoDisposeAsyncNotifierProviderImpl<
    EmployeeSchedulesVm, List<SchedulesModel>> {
  /// See also [EmployeeSchedulesVm].
  EmployeeSchedulesVmProvider(
    int userId,
    DateTime date,
  ) : this._internal(
          () => EmployeeSchedulesVm()
            ..userId = userId
            ..date = date,
          from: employeeSchedulesVmProvider,
          name: r'employeeSchedulesVmProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$employeeSchedulesVmHash,
          dependencies: EmployeeSchedulesVmFamily._dependencies,
          allTransitiveDependencies:
              EmployeeSchedulesVmFamily._allTransitiveDependencies,
          userId: userId,
          date: date,
        );

  EmployeeSchedulesVmProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
    required this.date,
  }) : super.internal();

  final int userId;
  final DateTime date;

  @override
  FutureOr<List<SchedulesModel>> runNotifierBuild(
    covariant EmployeeSchedulesVm notifier,
  ) {
    return notifier.build(
      userId,
      date,
    );
  }

  @override
  Override overrideWith(EmployeeSchedulesVm Function() create) {
    return ProviderOverride(
      origin: this,
      override: EmployeeSchedulesVmProvider._internal(
        () => create()
          ..userId = userId
          ..date = date,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
        date: date,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<EmployeeSchedulesVm,
      List<SchedulesModel>> createElement() {
    return _EmployeeSchedulesVmProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EmployeeSchedulesVmProvider &&
        other.userId == userId &&
        other.date == date;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);
    hash = _SystemHash.combine(hash, date.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EmployeeSchedulesVmRef
    on AutoDisposeAsyncNotifierProviderRef<List<SchedulesModel>> {
  /// The parameter `userId` of this provider.
  int get userId;

  /// The parameter `date` of this provider.
  DateTime get date;
}

class _EmployeeSchedulesVmProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<EmployeeSchedulesVm,
        List<SchedulesModel>> with EmployeeSchedulesVmRef {
  _EmployeeSchedulesVmProviderElement(super.provider);

  @override
  int get userId => (origin as EmployeeSchedulesVmProvider).userId;
  @override
  DateTime get date => (origin as EmployeeSchedulesVmProvider).date;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
