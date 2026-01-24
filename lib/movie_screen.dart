import 'dart:ui';
import 'package:flutter/material.dart';
import 'movie_card_widget.dart';
import 'movie_model.dart';

class MovieScreen extends StatefulWidget {
  const MovieScreen({super.key});

  @override
  State<MovieScreen> createState() => _MovieScreenState();
}

class _MovieScreenState extends State<MovieScreen> {

  List<MovieModel> movies = [
    MovieModel(
      'https://media.istockphoto.com/id/1340577488/photo/girl-enjoying-watching-a-nice-movie-at-the-cinema.jpg?s=612x612&w=0&k=20&c=88VNH4QDuRqNmCniFdaDdiSPDbwQp2h61BlUaK1T518=',
      'New Movie1',
      'John Deep',
      'Samer',
      'Example',
      DateTime.now(),
      ['Drama', 'Cat1', 'Cat2'],
    ),
    MovieModel(
      'https://media.gettyimages.com/id/1488301035/photo/buying-movie-tickets.jpg?s=612x612&w=gi&k=20&c=70mQ6cqRtMA4KJmdcXDrCR8xaQLD8Fa0Wsx-djHR6-Y=',
      'New Movie2',
      'John Deep',
      'Samer',
      'Example',
      DateTime.now().subtract(Duration(days: 1)),
      ['Drama', 'hello', 'Cat2'],
    ),
    MovieModel(
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTObE5VyFXLBbM2YBZ_5Sqg0Y-_PQSnhrLBGg&s',
      'New Movie3',
      'John Deep',
      'Samer',
      'Example',
      DateTime.now(),
      ['Drama', 'Cat1', 'Cat2'],
    ),
    MovieModel(
      'https://i.ytimg.com/vi/_nQJ8B5NtA8/hq720.jpg?sqp=-oaymwEhCK4FEIIDSFryq4qpAxMIARUAAAAAGAElAADIQj0AgKJD&rs=AOn4CLBc6zrlhrNt5kl1bxEtzBmqcYutpA',
      'New Movie4',
      'John Deep',
      'Samer',
      'Example',
      DateTime.now(),
      ['Drama', 'Cat1', 'Cat2'],
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(fit: BoxFit.fill, 'assets/images/example.png'),
            ),
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
              left:0,
              right: 0,
              bottom: 0,
              child: ListView.builder(
                itemBuilder: (context, index) {
                 return Padding(
                   padding: EdgeInsetsGeometry.only(bottom: 200),
                   child: MovieCard(
                      movie: MovieModel(
                        movies[index].imageUrl,
                        movies[index].movieName,
                        movies[index].director,
                        movies[index].writer,
                        movies[index].stars,
                        movies[index].releasedDate,
                        movies[index].categories,
                      ),
                    ),
                 );
                },
                itemCount: movies.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
