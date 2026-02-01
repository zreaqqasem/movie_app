// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  originalTitle: json['original_title'] as String,
  overview: json['overview'] as String,
  posterPath: json['poster_path'] as String?,
  backdropPath: json['backdrop_path'] as String?,
  popularity: (json['popularity'] as num).toDouble(),
  voteAverage: (json['vote_average'] as num).toDouble(),
  voteCount: (json['vote_count'] as num).toInt(),
  releaseDate: json['release_date'] as String?,
  genreIds: (json['genre_ids'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toList(),
  originalLanguage: json['original_language'] as String,
  adult: json['adult'] as bool,
  video: json['video'] as bool,
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'backdrop_path': instance.backdropPath,
      'popularity': instance.popularity,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'release_date': instance.releaseDate,
      'genre_ids': instance.genreIds,
      'original_language': instance.originalLanguage,
      'adult': instance.adult,
      'video': instance.video,
    };
