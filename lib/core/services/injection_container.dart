import 'package:get_it/get_it.dart';
import 'package:tdd_tutorial/src/auth/data/datasources/auth_remote_data_sourecs.dart';
import 'package:tdd_tutorial/src/auth/data/repos/auth_repo_implementations.dart';
import 'package:tdd_tutorial/src/auth/domain/repo/auth_repo.dart';
import 'package:tdd_tutorial/src/auth/domain/usescases/createuser.dart';
import 'package:tdd_tutorial/src/auth/presentation/cubit/authenication_cubit.dart';
import 'package:http/http.dart' as http;

import '../../src/auth/domain/usescases/get_user.dart';

 var sl=GetIt.instance;

Future<void> init() async {
  sl

  // App Logic
  
  ..registerFactory(
      () => AuthenticationCubit(
        createUser: sl(),
        getUsers: sl(),
      ),
    )

    // Use cases

    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // Repositories

    // whenever we need AuthRepo (this is a abstract class so we can't instantiate) as we to need to pass it's implementations
    ..registerLazySingleton<AuthRepo>(
        () => AuthenticationRepositoryImplementation(sl()))

    // Data Sources

    ..registerLazySingleton<AuthenticationRemoteSource>(
        () => AuthenticationRemoteSourceImpl(sl()))
    // this is registerLazySingleton(http.Client.new) same as instantiate classes like this one registerLazySingleton(() => http.Client())
    // since http is external dependency i used this method

    // external dependency

    ..registerLazySingleton(http.Client.new);
}
