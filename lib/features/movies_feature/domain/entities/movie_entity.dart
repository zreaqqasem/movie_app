// Domain Entity - Pure business logic, no dependencies on frameworks
import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final String originalTitle;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double popularity;
  final double voteAverage;
  final int voteCount;
  final DateTime? releaseDate;
  final List<int> genreIds;
  final String originalLanguage;
  final bool adult;
  final bool video;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.originalTitle,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.popularity,
    required this.voteAverage,
    required this.voteCount,
    this.releaseDate,
    required this.genreIds,
    required this.originalLanguage,
    required this.adult,
    required this.video,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        originalTitle,
        overview,
        posterPath,
        backdropPath,
        popularity,
        voteAverage,
        voteCount,
        releaseDate,
        genreIds,
        originalLanguage,
        adult,
        video,
      ];
}
