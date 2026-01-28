import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/features/movies_feature/data/models/movie_details_response.dart';
import 'package:movie_app/features/movies_feature/data/movie_service.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  bool loading = false;
  MovieDetails? movie;

  final MovieService _movieService = MovieService();

  _getMovieDetails() async {
    setState(() {
      loading = true;
    });
    movie = await _movieService.getMovieDetails(widget.movieId);
    log(movie?.posterPath ?? '');
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    _getMovieDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator.adaptive())
        : Scaffold(
            appBar: AppBar(),
            body: Stack(
              children: [
                Positioned(
                  child: Image.network(
                    fit: BoxFit.fill,
                    height: 450,
                    width: double.infinity,
                    '${MovieService.imageBaseUrl}${movie!.posterPath}',
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    width: 80,
                    height: 80,
                    child: Center(
                      child: Icon(Icons.play_arrow, color: Colors.white,size:60,),
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 5,
                  child: Text(
                    movie?.overview ?? '',style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
  }
}
