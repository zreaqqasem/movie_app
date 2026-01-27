import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movie_app/features/movies_feature/data/movie_response.dart';

class MovieService {
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500/';
  static const _baseUrl = 'https://api.themoviedb.org';
  static const _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZmVhNDBkNzg2ZmE5OTNlYTg3M2U4MmNjZDBiMTkwYiIsIm5iZiI6MTYxMjQ4MTYwMS4yNzksInN1YiI6IjYwMWM4NDQxMTEwOGE4MDAzZWM0NDMxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.t9G-Lthocb2yqFT6nWECqGhjFh4_DXLtTNjo076y3bg';
  final _header = {
    'Authorization': 'Bearer $_token',
    'Content-Type': 'application/json',
  };

  Future<List<Result>?> getTopRatedMovies() async {
    try {
      final url = Uri.parse('$_baseUrl/3/discover/movie?include_adult=false');
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

  //todo add new method for get popular api
  // add new model in models for this popular api
}
