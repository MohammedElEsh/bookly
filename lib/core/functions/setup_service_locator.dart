import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:bookly/core/utils/api_service.dart';
import 'package:bookly/features/home/data/local/data_sources/home_local_data_source.dart';
import 'package:bookly/features/home/data/remote/data_sources/home_remote_data_source.dart';
import 'package:bookly/features/home/data/repositories/home_repo_impl.dart';
import 'package:bookly/features/home/domain/repositories/home_repo.dart';

final locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerLazySingleton(() => Dio());

  locator.registerLazySingleton(() => ApiService(locator<Dio>()));

  locator.registerLazySingleton<HomeLocalDataSource>(
        () => HomeLocalDataSourceImpl(),
  );

  locator.registerLazySingleton<HomeRemoteDataSource>(
        () => HomeRemoteDataSourceImpl(locator<ApiService>()),
  );

  locator.registerLazySingleton<HomeRepo>(
        () => HomeRepoImpl(
      homeLocalDataSource: locator<HomeLocalDataSource>(),
      homeRemoteDataSource: locator<HomeRemoteDataSource>(),
    ),
  );
}