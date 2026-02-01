// Repository Implementation - Dependency Inversion Principle (DIP)
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/movies_feature/data/datasources/movies_remote_data_source.dart';
import 'package:movie_app/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_feature/domain/entities/movie_details_entity.dart';
import 'package:movie_app/features/movies_feature/domain/repositories/movies_repository.dart';

class MoviesRepositoryImpl implements MoviesRepository {
  final MoviesRemoteDataSource remoteDataSource;

  const MoviesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<MovieEntity>>> getTopRatedMovies(int page) async {
    return _getMovies(() => remoteDataSource.getTopRatedMovies(page));
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(int page) async {
    return _getMovies(() => remoteDataSource.getPopularMovies(page));
  }

  @override
  Future<Either<Failure, List<MovieEntity>>> getDiscoverMovies(int page) async {
    return _getMovies(() => remoteDataSource.getDiscoverMovies(page));
  }

  @override
  Future<Either<Failure, MovieDetailsEntity>> getMovieDetails(int movieId) async {
    try {
      log('Fetching movie details - id: $movieId');

      final response = await remoteDataSource.getMovieDetails(movieId);
      final entity = response.toEntity();

      return Right(entity);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      log('Unexpected error in getMovieDetails: ${e.toString()}');
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  // Helper method to reduce code duplication - DRY principle
  Future<Either<Failure, List<MovieEntity>>> _getMovies(
    Future<dynamic> Function() getMoviesFunction,
  ) async {
    try {
      final response = await getMoviesFunction();
      final entities = response.results
          .map((model) => model.toEntity())
          .toList()
          .cast<MovieEntity>();

      return Right(entities);
    } on DioException catch (e) {
      return Left(_handleDioException(e));
    } catch (e) {
      log('Unexpected error: ${e.toString()}');
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }

  // Single Responsibility - Error handling
  Failure _handleDioException(DioException e) {
    log('DioException: ${e.message}');

    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return const NetworkFailure('Connection timeout');
    } else if (e.type == DioExceptionType.connectionError) {
      return const NetworkFailure('No internet connection');
    } else if (e.response != null) {
      return ServerFailure(
        'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
      );
    } else {
      return NetworkFailure('Network error: ${e.message}');
    }
  }
}
