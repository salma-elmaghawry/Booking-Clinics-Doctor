import 'package:booking_clinics/data/services/remote/firebase_auth.dart';
import 'package:booking_clinics/data/services/remote/firebase_firestore.dart';
import 'package:booking_clinics/feature/home/data/repo/home_repo_impl.dart';
import 'package:booking_clinics/feature/see_all/data/see_all_repo_impl.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:location/location.dart';
import '../../data/services/local/local_storage.dart';
import '../../feature/map/data/repo/location_repo/location_repo_imp.dart';
import '../../feature/map/data/repo/map_repo/map_impl.dart';
import '../../feature/map/data/repo/routes_repo/routes_impl.dart';

final GetIt getIt = GetIt.instance;

void setupServiceLocator() {
  // ! _____ Repos _____ ! //
  getIt.registerLazySingleton<LocationImpl>(
    () => LocationImpl(Location()),
  );
  getIt.registerLazySingleton<MapImpl>(() => MapImpl());
  getIt.registerLazySingleton<RoutesImpl>(() => RoutesImpl());
  getIt.registerLazySingleton<HomeRepoImpl>(() => HomeRepoImpl());
  getIt.registerLazySingleton<SeeAllRepoImpl>(() => SeeAllRepoImpl());

  // ! _____ Services _____ ! //
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerLazySingleton<LocalStorage<Map<dynamic, dynamic>>>(
    () => LocalStorage<Map<dynamic, dynamic>>(),
  );
  getIt.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(),
  );
  getIt.registerLazySingleton<FirebaseFirestoreService>(
    () => FirebaseFirestoreService(),
  );
}
