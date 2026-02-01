// Movie Details Model with JSON Serialization
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_app/features/movies_feature/domain/entities/movie_details_entity.dart';

part 'movie_details_model.g.dart';

@JsonSerializable()
class MovieDetailsModel {
  final int id;
  final String title;
  final String? tagline;
  final String overview;
  @JsonKey(name: 'poster_path')
  final String? posterPath;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  @JsonKey(name: 'vote_average')
  final double voteAverage;
  @JsonKey(name: 'vote_count')
  final int voteCount;
  final double popularity;
  @JsonKey(name: 'release_date')
  final String? releaseDate;
  final int? runtime;
  final int? budget;
  final int? revenue;
  final String? status;
  @JsonKey(name: 'imdb_id')
  final String? imdbId;
  final List<GenreModel> genres;

  const MovieDetailsModel({
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

  factory MovieDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsModelToJson(this);

  MovieDetailsEntity toEntity() {
    return MovieDetailsEntity(
      id: id,
      title: title,
      tagline: tagline,
      overview: overview,
      posterPath: posterPath,
      backdropPath: backdropPath,
      voteAverage: voteAverage,
      voteCount: voteCount,
      popularity: popularity,
      releaseDate: releaseDate != null && releaseDate!.isNotEmpty
          ? DateTime.tryParse(releaseDate!)
          : null,
      runtime: runtime,
      budget: budget,
      revenue: revenue,
      status: status,
      imdbId: imdbId,
      genres: genres.map((g) => g.toEntity()).toList(),
    );
  }
}

@JsonSerializable()
class GenreModel {
  final int id;
  final String name;

  const GenreModel({
    required this.id,
    required this.name,
  });

  factory GenreModel.fromJson(Map<String, dynamic> json) =>
      _$GenreModelFromJson(json);

  Map<String, dynamic> toJson() => _$GenreModelToJson(this);

  GenreEntity toEntity() {
    return GenreEntity(
      id: id,
      name: name,
    );
  }
}
