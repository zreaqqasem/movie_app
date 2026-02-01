// Remote Data Source - Retrofit API Client
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:movie_app/features/movies_feature/data/models/movies_response_model.dart';
import 'package:movie_app/features/movies_feature/data/models/movie_details_model.dart';

part 'movies_remote_data_source.g.dart';

@RestApi()
abstract class MoviesRemoteDataSource {
  factory MoviesRemoteDataSource(Dio dio, {String baseUrl}) = _MoviesRemoteDataSource;

  @GET('/3/movie/top_rated')
  Future<MoviesResponseModel> getTopRatedMovies(@Query('page') int page);

  @GET('/3/movie/popular')
  Future<MoviesResponseModel> getPopularMovies(@Query('page') int page);

  @GET('/3/discover/movie')
  Future<MoviesResponseModel> getDiscoverMovies(@Query('page') int page);

  @GET('/3/movie/{movie_id}')
  Future<MovieDetailsModel> getMovieDetails(@Path('movie_id') int movieId);
}
