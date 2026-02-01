// Domain Entity for Movie Details
import 'package:equatable/equatable.dart';

class MovieDetailsEntity extends Equatable {
  final int id;
  final String title;
  final String? tagline;
  final String overview;
  final String? posterPath;
  final String? backdropPath;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final DateTime? releaseDate;
  final int? runtime;
  final int? budget;
  final int? revenue;
  final String? status;
  final String? imdbId;
  final List<GenreEntity> genres;

  const MovieDetailsEntity({
    required this.id,
    required this.title,
    this.tagline,
    required this.overview,
    this.posterPath,
    this.backdropPath,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    this.releaseDate,
    this.runtime,
    this.budget,
    this.revenue,
    this.status,
    this.imdbId,
    required this.genres,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        tagline,
        overview,
        posterPath,
        backdropPath,
        voteAverage,
        voteCount,
        popularity,
        releaseDate,
        runtime,
        budget,
        revenue,
        status,
        imdbId,
        genres,
      ];
}

class GenreEntity extends Equatable {
  final int id;
  final String name;

  const GenreEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
