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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Alignment Practice'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(
                'https://img.freepik.com/premium-vector/avatar-profile-icon-flat-style-female-user-profile-vector-illustration-isolated-background-women-profile-sign-business-concept_157943-38866.jpg?semt=ais_hybrid&w=740&q=80',
              ).image,
            ),
            color: Colors.blue,
            borderRadius: BorderRadius.all(Radius.circular(65)),
          ),
          height: 130,
          width: 130,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                bottom: -9,
                right: 10,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(65)),
                  ),
                  child: IconButton(
                    onPressed: () {
                      print('change image');
                    },
                    icon: Icon(Icons.camera_alt_outlined),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
