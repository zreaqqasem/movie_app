// Repository Implementation - Dependency Inversion Principle (DIP)
// Depends on abstractions (interfaces) not concretions
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/people_feature/data/datasources/people_remote_data_source.dart';
import 'package:movie_app/features/people_feature/domain/entities/person_entity.dart';
import 'package:movie_app/features/people_feature/domain/repositories/people_repository.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  final PeopleRemoteDataSource remoteDataSource;

  const PeopleRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PersonEntity>>> getPopularPeople(int page) async {
    try {
      log('Fetching popular people - page: $page');

      final response = await remoteDataSource.getPopularPeople(page);
      final entities = response.results.map((model) => model.toEntity()).toList();

      return Right(entities);
    } on DioException catch (e) {
      log('DioException in getPopularPeople: ${e.message}');

      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const Left(NetworkFailure('Connection timeout'));
      } else if (e.type == DioExceptionType.connectionError) {
        return const Left(NetworkFailure('No internet connection'));
      } else if (e.response != null) {
        return Left(ServerFailure(
          'Server error: ${e.response?.statusCode} - ${e.response?.statusMessage}',
        ));
      } else {
        return Left(NetworkFailure('Network error: ${e.message}'));
      }
    } catch (e) {
      log('Unexpected error in getPopularPeople: ${e.toString()}');
      return Left(ServerFailure('Unexpected error: ${e.toString()}'));
    }
  }
}
