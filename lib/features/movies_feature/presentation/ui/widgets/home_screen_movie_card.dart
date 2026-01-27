import 'package:flutter/material.dart';

class HomeMovieCard extends StatelessWidget {
  final String imageUrl;
  final String movieName;
  final String year;
  final String rating;

  const HomeMovieCard({
    super.key,
    required this.imageUrl,
    required this.movieName,
    required this.year,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 135,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                fit: BoxFit.fill,
                imageUrl,
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: CircleAvatar(
              radius: 15,
              backgroundColor: Colors.red,
              child: Center(
                child: Text(
                  rating,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  year,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  movieName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
