import 'package:remi/main.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Color color;
  final String title;
  final String content;

  const NoteCard({
    super.key,
    required this.color,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      width: width * .4,
      height: height * .25,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.only(top: 18, left: 10, right: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w100, color: white),
                ),
                Icon(Icons.dehaze, size: 15, color: white)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              content,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w400, color: white),
            ),
          ],
        ),
      ),
    );
  }
}
