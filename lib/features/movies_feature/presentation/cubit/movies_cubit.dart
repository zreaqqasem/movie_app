// Movies Cubit - Dependency Inversion Principle (DIP)
// Depends on use case abstractions, not implementation details
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies_feature/domain/usecases/get_discover_movies_usecase.dart';
import 'package:movie_app/features/movies_feature/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_app/features/movies_feature/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_app/features/movies_feature/domain/usecases/get_top_rated_movies_usecase.dart';
import 'package:movie_app/features/movies_feature/presentation/cubit/movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  final GetTopRatedMoviesUseCase getTopRatedMoviesUseCase;
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  final GetDiscoverMoviesUseCase getDiscoverMoviesUseCase;
  final GetMovieDetailsUseCase getMovieDetailsUseCase;

  MoviesCubit({
    required this.getTopRatedMoviesUseCase,
    required this.getPopularMoviesUseCase,
    required this.getDiscoverMoviesUseCase,
    required this.getMovieDetailsUseCase,
  }) : super(MoviesInitialState());

  Future<void> loadMovies({int page = 1}) async {
    emit(MoviesLoadingState());

    // Fetch all three categories concurrently for better performance
    final results = await Future.wait([
      getTopRatedMoviesUseCase(page),
      getPopularMoviesUseCase(page),
      getDiscoverMoviesUseCase(page),
    ]);

    // Check if any request failed
    final failures = results.where((result) => result.isLeft()).toList();
    if (failures.isNotEmpty) {
      failures.first.fold(
        (failure) => emit(MoviesErrorState(message: failure.message)),
        (_) => null,
      );
      return;
    }

    // Extract successful results
    final topRated = results[0].getOrElse(() => []);
    final popular = results[1].getOrElse(() => []);
    final discover = results[2].getOrElse(() => []);

    emit(MoviesLoadedState(
      topRated: topRated,
      popular: popular,
      discover: discover,
    ));
  }

  Future<void> loadMovieDetails(int movieId) async {
    emit(MovieDetailsLoadingState());

    final result = await getMovieDetailsUseCase(movieId);

    result.fold(
      (failure) => emit(MovieDetailsErrorState(message: failure.message)),
      (movieDetails) => emit(MovieDetailsLoadedState(movieDetails: movieDetails)),
    );
  }
}
