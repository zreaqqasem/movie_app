// Use Case - Single Responsibility Principle (SRP)
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/movies_feature/domain/entities/movie_details_entity.dart';
import 'package:movie_app/features/movies_feature/domain/repositories/movies_repository.dart';

class GetMovieDetailsUseCase {
  final MoviesRepository repository;

  const GetMovieDetailsUseCase({required this.repository});

  Future<Either<Failure, MovieDetailsEntity>> call(int movieId) async {
    if (movieId < 1) {
      return const Left(ValidationFailure('Movie ID must be greater than 0'));
    }
    return await repository.getMovieDetails(movieId);
  }
}
