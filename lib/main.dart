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

  List<String> images =  [
    'https://img.freepik.com/free-photo/courage-man-jump-through-gap-hill-business-concept-idea_1323-262.jpg?semt=ais_hybrid&w=740&q=80',
    'https://media.istockphoto.com/id/814423752/photo/eye-of-model-with-colorful-art-make-up-close-up.jpg?s=612x612&w=0&k=20&c=l15OdMWjgCKycMMShP8UK94ELVlEGvt7GmB_esHWPYE='
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
        child: Column(
          children: [
            Image.network(images[currentIndex]),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                setState(() {
                  if (currentIndex == 0){
                    currentIndex = 1;
                  }else{
                    currentIndex = 0;
                  }
               });
              },
              child: Text(
                'Change Image',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
