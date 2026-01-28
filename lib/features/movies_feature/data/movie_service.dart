import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movie_app/features/movies_feature/data/models/movie_details_response.dart';
import 'package:movie_app/features/movies_feature/data/models/movie_response.dart';

class MovieService {
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500/';
  static const _baseUrl = 'https://api.themoviedb.org';
  static const _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZmVhNDBkNzg2ZmE5OTNlYTg3M2U4MmNjZDBiMTkwYiIsIm5iZiI6MTYxMjQ4MTYwMS4yNzksInN1YiI6IjYwMWM4NDQxMTEwOGE4MDAzZWM0NDMxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.t9G-Lthocb2yqFT6nWECqGhjFh4_DXLtTNjo076y3bg';
  final _header = {
    'Authorization': 'Bearer $_token',
    'Content-Type': 'application/json',
  };

  Future<List<Result>?> getTopRatedMovies(int pageNumber) async {
    try {
      final url = Uri.parse('$_baseUrl/3/movie/upcoming?language=en-US&page=$pageNumber');
      final response = await http.get(url,headers: _header);
      if(response.statusCode == 200){
        final result = jsonDecode(response.body);
        final MovieResponse finalResponse = MovieResponse.fromJson(result);
        return finalResponse.results;
      }else{
        return null;
      }
    } catch (error) {
      return null;
    }
  }

  Future<List<Result>?>getPopularMovies(int pageNumber) async {

    try {
      final url = Uri.parse('$_baseUrl/3/movie/popular?language=en-US&page=$pageNumber');
      final result = await http.get(url,headers: _header);
      final resultToReturn = jsonDecode(result.body);
      final popularMovies = MovieResponse.fromJson(resultToReturn);
      return popularMovies.results;

    }catch(e){
      return null;
    }
  }

  Future<List<Result>?>getDiscoverMovies(int pageNumber) async {

    try {
      final url = Uri.parse('$_baseUrl/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=$pageNumber&sort_by=popularity.desc');
      final result = await http.get(url,headers: _header);
      final resultToReturn = jsonDecode(result.body);
      final popularMovies = MovieResponse.fromJson(resultToReturn);
      return popularMovies.results;
    }catch(e){
      return null;
    }
  }

  Future<MovieDetails?>getMovieDetails(int movieId)async{

    try {
      final url = Uri.parse('$_baseUrl/3/movie/$movieId?language=en-US');
      final result = await http.get(url,headers: _header);
      final resultToReturn = jsonDecode(result.body);
      final movieDetails = MovieDetails.fromJson(resultToReturn);
      return movieDetails;
    }catch (e){
      return null;
    }
  }
}
