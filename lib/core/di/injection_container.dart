import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import '../../data/datasources/user_local_datasource.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/delete_user.dart';
import '../../domain/usecases/get_random_user.dart';
import '../../domain/usecases/get_saved_users.dart';
import '../../domain/usecases/is_user_saved.dart';
import '../../domain/usecases/save_user.dart';
import '../../presentation/cubits/saved_users/saved_users_cubit.dart';
import '../../presentation/cubits/user_detail/user_detail_cubit.dart';
import '../../presentation/cubits/user_list/user_list_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  sl.registerFactory(
    () => UserListCubit(
      getRandomUser: sl(),
    ),
  );

  sl.registerFactory(
    () => UserDetailCubit(
      saveUser: sl(),
      deleteUser: sl(),
      isUserSaved: sl(),
    ),
  );

  sl.registerFactory(
    () => SavedUsersCubit(
      getSavedUsers: sl(),
      deleteUser: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetRandomUser(sl()));
  sl.registerLazySingleton(() => SaveUser(sl()));
  sl.registerLazySingleton(() => GetSavedUsers(sl()));
  sl.registerLazySingleton(() => DeleteUser(sl()));
  sl.registerLazySingleton(() => IsUserSaved(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(client: sl()),
  );

  sl.registerLazySingleton<UserLocalDataSource>(
    () => UserLocalDataSourceImpl(),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}

