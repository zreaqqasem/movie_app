// Use Case - Single Responsibility Principle (SRP)
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_feature/domain/repositories/movies_repository.dart';

class GetTopRatedMoviesUseCase {
  final MoviesRepository repository;

  const GetTopRatedMoviesUseCase({required this.repository});

  Future<Either<Failure, List<MovieEntity>>> call(int page) async {
    if (page < 1) {
      return const Left(ValidationFailure('Page number must be greater than 0'));
    }
    return await repository.getTopRatedMovies(page);
  }
}
