// Dependency Injection Container - Dependency Inversion Principle (DIP)
// All dependencies are injected through abstractions
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/core/config/api_config.dart';

// People Feature
import 'package:movie_app/features/people_feature/data/datasources/people_remote_data_source.dart';
import 'package:movie_app/features/people_feature/data/repositories/people_repository_impl.dart';
import 'package:movie_app/features/people_feature/domain/repositories/people_repository.dart';
import 'package:movie_app/features/people_feature/domain/usecases/get_popular_people_usecase.dart';
import 'package:movie_app/features/people_feature/presentation/cubit/people_cubit.dart';

// Movies Feature
import 'package:movie_app/features/movies_feature/data/datasources/movies_remote_data_source.dart';
import 'package:movie_app/features/movies_feature/data/repositories/movies_repository_impl.dart';
import 'package:movie_app/features/movies_feature/domain/repositories/movies_repository.dart';
import 'package:movie_app/features/movies_feature/domain/usecases/get_discover_movies_usecase.dart';
import 'package:movie_app/features/movies_feature/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_app/features/movies_feature/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_app/features/movies_feature/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:movie_app/features/movies_feature/presentation/cubit/movies_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // ============ Features ============

  // --- People Feature ---

  // Cubit
  sl.registerFactory(
    () => PeopleCubit(getPopularPeopleUseCase: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => GetPopularPeopleUseCase(repository: sl()),
  );

  // Repository
  sl.registerLazySingleton<PeopleRepository>(
    () => PeopleRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources (Retrofit)
  sl.registerLazySingleton<PeopleRemoteDataSource>(
    () => PeopleRemoteDataSource(sl()),
  );

  // --- Movies Feature ---

  // Cubit
  sl.registerFactory(
    () => MoviesCubit(
      getTopRatedMoviesUseCase: sl(),
      getPopularMoviesUseCase: sl(),
      getDiscoverMoviesUseCase: sl(),
      getMovieDetailsUseCase: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(
    () => GetTopRatedMoviesUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => GetPopularMoviesUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => GetDiscoverMoviesUseCase(repository: sl()),
  );

  sl.registerLazySingleton(
    () => GetMovieDetailsUseCase(repository: sl()),
  );

  // Repository
  sl.registerLazySingleton<MoviesRepository>(
    () => MoviesRepositoryImpl(remoteDataSource: sl()),
  );

  // Data Sources (Retrofit)
  sl.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSource(sl()),
  );

  // ============ Core ============

  // Dio
  sl.registerLazySingleton<Dio>(() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: ApiConfig.headers,
      ),
    );

    // Add interceptors for logging, error handling, etc.
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
        request: true,
      ),
    );

    return dio;
  });
}
