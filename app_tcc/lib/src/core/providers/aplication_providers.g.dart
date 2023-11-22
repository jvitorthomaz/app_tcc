// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'aplication_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$restClientHash() => r'0ee58f1fd102b2016ed621885f1e8d52ed00da66';

/// See also [restClient].
@ProviderFor(restClient)
final restClientProvider = Provider<RestClient>.internal(
  restClient,
  name: r'restClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$restClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RestClientRef = ProviderRef<RestClient>;
String _$userRespositoryHash() => r'37724404d51814c28cfa0672e54b672d99526122';

/// See also [userRespository].
@ProviderFor(userRespository)
final userRespositoryProvider = Provider<UserRespository>.internal(
  userRespository,
  name: r'userRespositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userRespositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserRespositoryRef = ProviderRef<UserRespository>;
String _$userLoginServiceHash() => r'22c8dfbfe6789315416c83efce21d7cce2f10295';

/// See also [userLoginService].
@ProviderFor(userLoginService)
final userLoginServiceProvider = Provider<UserLoginService>.internal(
  userLoginService,
  name: r'userLoginServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userLoginServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserLoginServiceRef = ProviderRef<UserLoginService>;
String _$getMeHash() => r'7fb91ceaae63dadb01f42bb3721c09782ac62cc0';

/// See also [getMe].
@ProviderFor(getMe)
final getMeProvider = FutureProvider<UserModel>.internal(
  getMe,
  name: r'getMeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getMeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetMeRef = FutureProviderRef<UserModel>;
String _$placesRepositoryHash() => r'665868acc9681446b5328fb85650f40494257c1e';

/// See also [placesRepository].
@ProviderFor(placesRepository)
final placesRepositoryProvider = Provider<PlacesRepository>.internal(
  placesRepository,
  name: r'placesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$placesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlacesRepositoryRef = ProviderRef<PlacesRepository>;
String _$getAdmPlaceHash() => r'7ce018f656872cdd86e652eb4c2b3b684572bc51';

/// See also [getAdmPlace].
@ProviderFor(getAdmPlace)
final getAdmPlaceProvider = FutureProvider<PlaceModel>.internal(
  getAdmPlace,
  name: r'getAdmPlaceProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAdmPlaceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAdmPlaceRef = FutureProviderRef<PlaceModel>;
String _$logoutHash() => r'fbedb8b76c54033b9bff184c1736fcb5f24979a4';

/// See also [logout].
@ProviderFor(logout)
final logoutProvider = AutoDisposeFutureProvider<void>.internal(
  logout,
  name: r'logoutProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$logoutHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LogoutRef = AutoDisposeFutureProviderRef<void>;
String _$schedulesRepositoryHash() =>
    r'd5dd18c1329ff8829461e4146eba7c9514cf5314';

/// See also [schedulesRepository].
@ProviderFor(schedulesRepository)
final schedulesRepositoryProvider =
    AutoDisposeProvider<SchedulesRepository>.internal(
  schedulesRepository,
  name: r'schedulesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$schedulesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SchedulesRepositoryRef = AutoDisposeProviderRef<SchedulesRepository>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
