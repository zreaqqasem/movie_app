import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
      ),
      home: const AlignmentPractice(),
    );
  }
}

class AlignmentPractice extends StatefulWidget {
  const AlignmentPractice({super.key});

  @override
  State<AlignmentPractice> createState() => _AlignmentPracticeState();
}

class _AlignmentPracticeState extends State<AlignmentPractice> {
  List<String> images = [
    'https://img.freepik.com/free-photo/courage-man-jump-through-gap-hill-business-concept-idea_1323-262.jpg?semt=ais_hybrid&w=740&q=80',
    'https://media.istockphoto.com/id/814423752/photo/eye-of-model-with-colorful-art-make-up-close-up.jpg?s=612x612&w=0&k=20&c=l15OdMWjgCKycMMShP8UK94ELVlEGvt7GmB_esHWPYE=',
  ];
  int currentIndex = 0;

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
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.white.withOpacity(0.1)),
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
                    style: TextStyle(fontSize: 20, color: Colors.white,),
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
