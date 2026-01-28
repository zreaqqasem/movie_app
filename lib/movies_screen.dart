import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movies_feature/data/movie_response.dart';
import 'package:movie_app/features/movies_feature/data/movie_service.dart';
import 'package:movie_app/features/movies_feature/presentation/ui/widgets/home_screen_movie_card.dart';

import 'movie_model.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<Result> movies = [];
  final _movieService = MovieService();
  bool isLoading = false;

  _getMovies() async {
    setState(() {
      isLoading = true;
    });
    movies = await _movieService.getTopRatedMovies() ?? [];
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _getMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(height: 200),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Up Coming', style: TextStyle(fontSize: 20)),
                        SizedBox(height: 6),
                        SizedBox(
                          height: 230,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              log(movies[index].posterPath);
                              return Padding(
                                padding: EdgeInsetsGeometry.only(right: 5),
                                child: HomeMovieCard(
                                  imageUrl:
                                      '${MovieService.imageBaseUrl}${movies[index].posterPath}',
                                  movieName: movies[index].title,
                                  year: movies[index].releaseDate.year
                                      .toString(),
                                  rating: movies[index].voteAverage
                                      .floor()
                                      .toString(),
                                ),
                              );
                            },
                            itemCount: movies.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Popular', style: TextStyle(fontSize: 20)),
                        SizedBox(height: 6),
                        SizedBox(
                          height: 500,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: (movies.length / 2).ceil(),
                            // Half the count (rounded up)
                            itemBuilder: (context, index) {
                              final firstIndex = index * 2;
                              final secondIndex = index * 2 + 1;

                              return Padding(
                                padding: const EdgeInsets.only(right: 4),
                                // Fixed: EdgeInsets not EdgeInsetsGeometry
                                child: Column(
                                  children: [
                                    HomeMovieCard(
                                      imageUrl:
                                          '${MovieService.imageBaseUrl}${movies[firstIndex].posterPath}',
                                      movieName: movies[firstIndex].title,
                                      year: movies[firstIndex].releaseDate.year
                                          .toString(),
                                      rating: movies[firstIndex].voteAverage
                                          .floor()
                                          .toString(),
                                    ),
                                    const SizedBox(height: 5),
                                    // Only show second card if it exists (handles odd number of movies)
                                    if (secondIndex < movies.length)
                                      HomeMovieCard(
                                        imageUrl:
                                            '${MovieService.imageBaseUrl}${movies[secondIndex].posterPath}',
                                        movieName: movies[secondIndex].title,
                                        year: movies[secondIndex]
                                            .releaseDate
                                            .year
                                            .toString(),
                                        rating: movies[secondIndex].voteAverage
                                            .floor()
                                            .toString(),
                                      ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
