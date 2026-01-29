import 'package:flutter/material.dart';
import 'package:movie_app/features/movies_feature/data/models/movie_model.dart';

class MovieCard extends StatelessWidget {
  final MovieModel movie;

  const MovieCard({super.key, required this.movie});

  Widget buildCategoryCard(String category) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFF4B5940),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsetsGeometry.only(
            left: 10,
            right: 10,
            top: 2,
            bottom: 2,
          ),
          child: Text(category, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }

  Widget buildRowDescription(
    String title,
    String details,
    Color titleColor,
    Color descriptionColor,
  ) {
    return Row(
      children: [
        Text('$title: ', style: TextStyle(color: titleColor, fontSize: 20)),
        Text(details, style: TextStyle(color: descriptionColor, fontSize: 20)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 600,
      width: 300,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            bottom: -100,
            left: 50,
            right: 50,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              height: 500,
              child: Padding(
                padding: EdgeInsetsGeometry.only(
                  top: 200,
                  bottom: 11,
                  left: 11,
                  right: 11,
                ),
                child: Column(
                  children: [
                    Text(
                      movie.movieName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0XFF261511),
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      spacing: 3,
                      children: movie.categories.map((category){
                        return buildCategoryCard(category);
                      }).toList(),
                    ),
                    SizedBox(height: 10),
                    buildRowDescription(
                      'Director',
                      movie.director,
                      Color(0XFF8E8380),
                      Colors.black,
                    ),
                    buildRowDescription(
                      'Writer',
                      movie.writer,
                      Color(0XFF8E8380),
                      Colors.black,
                    ),
                    buildRowDescription(
                      'Stars',
                      movie.stars,
                      Color(0XFF8E8380),
                      Colors.black,
                    ),
                    SizedBox(height: 20),
                    buildRowDescription(
                      'Released Date',
                      '${movie.releasedDate.day}/${movie.releasedDate.month}/${movie.releasedDate.year}',
                      Color(0XFF5BAB0A),
                      Color(0XFF5BAB0A),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 200,
            left: 100,
            right: 100,
            child: SizedBox(
              height: 400,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
