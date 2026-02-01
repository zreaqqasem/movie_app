// Movies Screen - Single Responsibility Principle (SRP)
// Only responsible for UI rendering and user interaction
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/config/api_config.dart';
import 'package:movie_app/core/di/injection_container.dart';
import 'package:movie_app/features/movies_feature/presentation/cubit/movies_cubit.dart';
import 'package:movie_app/features/movies_feature/presentation/cubit/movies_state.dart';
import 'package:movie_app/features/movies_feature/presentation/ui/widgets/discover_movie_card.dart';
import 'package:movie_app/features/movies_feature/presentation/ui/widgets/home_screen_movie_card.dart';
import 'package:movie_app/features/movies_feature/presentation/ui/screens/movie_details_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MoviesCubit>()..loadMovies(),
      child: Scaffold(
        body: BlocBuilder<MoviesCubit, MoviesState>(
          builder: (context, state) {
            if (state is MoviesLoadingState) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is MoviesLoadedState) {
              return _buildMoviesContent(context, state);
            } else if (state is MoviesErrorState) {
              return _buildErrorWidget(context, state.message);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildMoviesContent(BuildContext context, MoviesLoadedState state) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Discover Movies Section
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: state.discover.length,
                  itemBuilder: (context, index) {
                    final movie = state.discover[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MovieDetailsScreen(
                                movieId: movie.id,
                              ),
                            ),
                          );
                        },
                        child: DiscoverMovieCard(
                          imageUrl: movie.posterPath != null
                              ? '${ApiConfig.imageBaseUrl}${movie.posterPath}'
                              : '',
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Top Rated Movies Section
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Top Rated', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.topRated.length,
                      itemBuilder: (context, index) {
                        final movie = state.topRated[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MovieDetailsScreen(
                                    movieId: movie.id,
                                  ),
                                ),
                              );
                            },
                            child: HomeMovieCard(
                              imageUrl: movie.posterPath != null
                                  ? '${ApiConfig.imageBaseUrl}${movie.posterPath}'
                                  : '',
                              movieName: movie.title,
                              year: movie.releaseDate?.year.toString() ?? 'N/A',
                              rating: movie.voteAverage.floor().toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Popular Movies Section
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Popular', style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 6),
                  SizedBox(
                    height: 410,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: (state.popular.length / 2).ceil(),
                      itemBuilder: (context, index) {
                        final firstIndex = index * 2;
                        final secondIndex = index * 2 + 1;

                        return Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailsScreen(
                                        movieId: state.popular[firstIndex].id,
                                      ),
                                    ),
                                  );
                                },
                                child: HomeMovieCard(
                                  imageUrl: state.popular[firstIndex].posterPath != null
                                      ? '${ApiConfig.imageBaseUrl}${state.popular[firstIndex].posterPath}'
                                      : '',
                                  movieName: state.popular[firstIndex].title,
                                  year: state.popular[firstIndex].releaseDate?.year.toString() ?? 'N/A',
                                  rating: state.popular[firstIndex].voteAverage.floor().toString(),
                                ),
                              ),
                              const SizedBox(height: 5),
                              if (secondIndex < state.popular.length)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MovieDetailsScreen(
                                          movieId: state.popular[secondIndex].id,
                                        ),
                                      ),
                                    );
                                  },
                                  child: HomeMovieCard(
                                    imageUrl: state.popular[secondIndex].posterPath != null
                                        ? '${ApiConfig.imageBaseUrl}${state.popular[secondIndex].posterPath}'
                                        : '',
                                    movieName: state.popular[secondIndex].title,
                                    year: state.popular[secondIndex].releaseDate?.year.toString() ?? 'N/A',
                                    rating: state.popular[secondIndex].voteAverage.floor().toString(),
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

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            'Error',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              context.read<MoviesCubit>().loadMovies();
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
