// Data Model with JSON Serialization - Single Responsibility Principle (SRP)
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/features/movies_feature/domain/entities/movie_entity.dart';

part 'movie_model.g.dart';

@JsonSerializable()
class MovieModel {
  final int id;
  final String title;
  @JsonKey(name: 'original_title')
  final String originalTitle;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final double popularity;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  @JsonKey(name: 'genre_ids')
  final List<int> genreIds;
  @JsonKey(name: 'original_language')
  final String originalLanguage;
  final bool adult;
  final bool video;

  const MovieModel({
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

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  // Convert to domain entity - Liskov Substitution Principle (LSP)
  MovieEntity toEntity() {
    return MovieEntity(
      id: id,
      title: title,
      originalTitle: originalTitle,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      popularity: popularity,
      voteAverage: voteAverage,
      voteCount: voteCount,
      releaseDate: releaseDate != null && releaseDate!.isNotEmpty
          ? DateTime.tryParse(releaseDate!)
          : null,
      genreIds: genreIds,
      originalLanguage: originalLanguage,
      adult: adult,
      video: video,
    );
  }
}
