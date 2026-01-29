import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PeopleCard extends StatelessWidget {
  final int index;
  final String imageUrl;
  final String actorName;
  final Function(int) onClick;
  final VoidCallback print;

  const PeopleCard({
    super.key,
    required this.imageUrl,
    required this.actorName,
    required this.onClick,
    required this.print,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onClick(index);
        print();
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 2.2,
        height: MediaQuery.of(context).size.width / 1.9,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(imageUrl,fit: BoxFit.fill,),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 5,
              child: Text(
                actorName,
                style: TextStyle(fontSize: 15, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
