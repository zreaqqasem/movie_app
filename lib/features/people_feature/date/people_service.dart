import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'models/popular_response_model.dart';

class PeopleService {

  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500/';
  static const _baseUrl = 'https://api.themoviedb.org';
  static const _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI1ZmVhNDBkNzg2ZmE5OTNlYTg3M2U4MmNjZDBiMTkwYiIsIm5iZiI6MTYxMjQ4MTYwMS4yNzksInN1YiI6IjYwMWM4NDQxMTEwOGE4MDAzZWM0NDMxOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.t9G-Lthocb2yqFT6nWECqGhjFh4_DXLtTNjo076y3bg';
  final _header = {
    'Authorization': 'Bearer $_token',
    'Content-Type': 'application/json',
  };

  Future<List<Result>?>getPeople(int pageNumber)async{
    log('getPeople api');
    try {
      final url = Uri.parse('$_baseUrl/3/person/popular?language=en-US&page=$pageNumber');
      final response = await http.get(url,headers: _header);
      if(response.statusCode == 200){
        final result = jsonDecode(response.body);
        final PopularResponse finalResponse = PopularResponse.fromJson(result);
        return finalResponse.results;
      }else{
        return null;
      }
    } catch (error) {
      log(error.toString());
      return null;
    }
  }
}