// Repository Interface - Dependency Inversion Principle (DIP)
import 'package:dartz/dartz.dart';
import 'package:movie_app/core/error/failures.dart';
import 'package:movie_app/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_feature/domain/entities/movie_details_entity.dart';

// Interface Segregation Principle (ISP) - Focused interface for movie operations
abstract class MoviesRepository {
  Future<Either<Failure, List<MovieEntity>>> getTopRatedMovies(int page);
  Future<Either<Failure, List<MovieEntity>>> getPopularMovies(int page);
  Future<Either<Failure, List<MovieEntity>>> getDiscoverMovies(int page);
  Future<Either<Failure, MovieDetailsEntity>> getMovieDetails(int movieId);
}
