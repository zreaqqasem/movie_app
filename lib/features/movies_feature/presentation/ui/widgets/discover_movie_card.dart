import 'package:flutter/cupertino.dart';

class DiscoverMovieCard extends StatelessWidget {
  final String imageUrl;

  const DiscoverMovieCard({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(imageUrl,fit: BoxFit.fill,),
      ),
    );
  }
}
