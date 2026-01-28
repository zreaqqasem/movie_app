import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movies_feature/data/models/movie_response.dart';
import 'package:movie_app/features/movies_feature/data/movie_service.dart';
import 'package:movie_app/features/movies_feature/presentation/ui/screens/movie_details_screen.dart';
import 'package:movie_app/features/movies_feature/presentation/ui/widgets/discover_movie_card.dart';
import 'package:movie_app/features/movies_feature/presentation/ui/widgets/home_screen_movie_card.dart';

import '../../../../../movie_model.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({super.key});

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  List<Result> upComingMovies = [];
  List<Result> popularMovies = [];
  List<Result> discoverMovies = [];

  final _movieService = MovieService();
  bool isLoading = false;

  _getMovies() async {
    setState(() {
      isLoading = true;
    });
    upComingMovies = await _movieService.getTopRatedMovies(1) ?? [];
    popularMovies = await _movieService.getPopularMovies(1) ?? [];
    discoverMovies = await _movieService.getDiscoverMovies(1) ?? [];
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
                  SizedBox(height: 40),
                  Padding(
                    padding: EdgeInsetsGeometry.only(left: 10),
                    child: SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsetsGeometry.only(right: 5),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailsScreen(
                                      movieId: discoverMovies[index].id,
                                    ),
                                  ),
                                );
                              },
                              child: DiscoverMovieCard(
                                imageUrl:
                                    '${MovieService.imageBaseUrl}${discoverMovies[index].posterPath}',
                              ),
                            ),
                          );
                        },
                        itemCount: discoverMovies.length,
                      ),
                    ),
                  ),
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
                              log(upComingMovies[index].posterPath);
                              return Padding(
                                padding: EdgeInsetsGeometry.only(right: 5),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MovieDetailsScreen(
                                              movieId: upComingMovies[index].id,
                                            ),
                                      ),
                                    );
                                  },
                                  child: HomeMovieCard(
                                    imageUrl:
                                        '${MovieService.imageBaseUrl}${upComingMovies[index].posterPath}',
                                    movieName: upComingMovies[index].title,
                                    year: upComingMovies[index].releaseDate.year
                                        .toString(),
                                    rating: upComingMovies[index].voteAverage
                                        .floor()
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            itemCount: upComingMovies.length,
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
                            itemCount: (popularMovies.length / 2).ceil(),
                            // Half the count (rounded up)
                            itemBuilder: (context, index) {
                              final firstIndex = index * 2;
                              final secondIndex = index * 2 + 1;

                              return Padding(
                                padding: const EdgeInsets.only(right: 4),
                                // Fixed: EdgeInsets not EdgeInsetsGeometry
                                child: Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                MovieDetailsScreen(
                                                  movieId:
                                                      popularMovies[firstIndex]
                                                          .id,
                                                ),
                                          ),
                                        );
                                      },
                                      child: HomeMovieCard(
                                        imageUrl:
                                            '${MovieService.imageBaseUrl}${popularMovies[firstIndex].posterPath}',
                                        movieName:
                                            popularMovies[firstIndex].title,
                                        year: popularMovies[firstIndex]
                                            .releaseDate
                                            .year
                                            .toString(),
                                        rating: popularMovies[firstIndex]
                                            .voteAverage
                                            .floor()
                                            .toString(),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    // Only show second card if it exists (handles odd number of movies)
                                    if (secondIndex < popularMovies.length)
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailsScreen(
                                                    movieId:
                                                        popularMovies[secondIndex]
                                                            .id,
                                                  ),
                                            ),
                                          );
                                        },
                                        child: HomeMovieCard(
                                          imageUrl:
                                              '${MovieService.imageBaseUrl}${popularMovies[secondIndex].posterPath}',
                                          movieName:
                                              popularMovies[secondIndex].title,
                                          year: popularMovies[secondIndex]
                                              .releaseDate
                                              .year
                                              .toString(),
                                          rating: popularMovies[secondIndex]
                                              .voteAverage
                                              .floor()
                                              .toString(),
                                        ),
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
