// BLoC States - Single Responsibility Principle (SRP)
import 'package:equatable/equatable.dart';
import 'package:movie_app/features/movies_feature/domain/entities/movie_entity.dart';
import 'package:movie_app/features/movies_feature/domain/entities/movie_details_entity.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object?> get props => [];
}

class MoviesInitialState extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final List<MovieEntity> topRated;
  final List<MovieEntity> popular;
  final List<MovieEntity> discover;

  const MoviesLoadedState({
    required this.topRated,
    required this.popular,
    required this.discover,
  });

  @override
  List<Object?> get props => [topRated, popular, discover];
}

class MoviesErrorState extends MoviesState {
  final String message;

  const MoviesErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class MovieDetailsLoadingState extends MoviesState {}

class MovieDetailsLoadedState extends MoviesState {
  final MovieDetailsEntity movieDetails;

  const MovieDetailsLoadedState({required this.movieDetails});

  @override
  List<Object?> get props => [movieDetails];
}

class MovieDetailsErrorState extends MoviesState {
  final String message;

  const MovieDetailsErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
