import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import '../../data/services/local/local_storage.dart';
import '../../data/services/remote/firebase_auth.dart';
import '../../data/services/remote/firebase_firestore.dart';
import '../../features/auth/data/auth_services.dart';
import '../../features/home/data/repo/home_repo_impl.dart';
import '../../features/map/data/repo/location_repo/location_repo_imp.dart';
import '../../features/map/data/repo/map_repo/map_impl.dart';
import '../../features/map/data/repo/routes_repo/routes_impl.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // ! _____ Repos _____ ! //
  getIt.registerLazySingleton<LocationImpl>(
    () => LocationImpl(Location()),
  );
  getIt.registerLazySingleton<MapImpl>(() => MapImpl());
  getIt.registerLazySingleton<RoutesImpl>(() => RoutesImpl());
  getIt.registerLazySingleton<HomeRepoImpl>(() => HomeRepoImpl());

  // ! _____ Services _____ ! //
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<LocalStorage<Map<dynamic, dynamic>>>(
    () => LocalStorage<Map<dynamic, dynamic>>(),
  );
  getIt.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(),
  );
  getIt.registerLazySingleton<AuthenticationServices>(
    () => AuthenticationServices(),
  );
  getIt.registerLazySingleton<FirebaseFirestoreService>(
    () => FirebaseFirestoreService(),
  );
}
