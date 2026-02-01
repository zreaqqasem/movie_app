import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/features/movies_feature/presentation/ui/screens/movies_screen.dart';
import 'package:movie_app/features/people_feature/presentation/ui/screens/people_screen.dart';

class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  int currentIndex = 0;
  final pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [
          MoviesScreen(),
          Container(color: Colors.red),
          PeopleScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.movie,
              color: currentIndex == 0 ? Colors.redAccent : Colors.grey,
            ),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.tv,
              color: currentIndex == 1 ? Colors.redAccent : Colors.grey,
            ),
            label: 'TV',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.people,
              color: currentIndex == 2 ? Colors.redAccent : Colors.grey,
            ),
            label: 'People',
          ),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
          pageController.jumpToPage(index);
          log(index.toString());
        },
      ),
    );
  }
}
