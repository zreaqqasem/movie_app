import 'package:flutter/material.dart';
import 'package:movie_app/movie_model.dart';

class MovieScreen extends StatelessWidget{
  final MovieModel movie;
  const MovieScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Image.network(movie.imageUrl),
      ),
    );
  }
}