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
              child: Stack(
                children: [
                  Positioned.fill(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(color: Colors.grey.withOpacity(0.1)),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    top: 40,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        SizedBox(width: 57.7),
                        Text(
                          'October 19',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 100,
                    left: 10,
                    right: 0,
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
                                  imageUrl:MovieService.imageBaseUrl+'${movies[index].posterPath}',
                                  movieName: movies[index].title,
                                  year: movies[index].releaseDate.year
                                      .toString(),
                                  rating: movies[index].voteAverage.floor().toString(),
                                ),
                              );
                            },
                            itemCount: movies.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 400,
                    left: 10,
                    right: 0,
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
                             // todo return popular style;
                            },
                            itemCount: movies.length,
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
