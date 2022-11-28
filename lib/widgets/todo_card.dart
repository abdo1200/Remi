import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({super.key});

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: mode.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.2),
            spreadRadius: .5,
            blurRadius: 7,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text('Collage Project  ',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      color: mode.textColor)),
              Text(' ( 3 of 5 tasks)',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w100,
                      color: mode.textColor)),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Icon(
                Icons.check_circle_outline,
                color: mainColor,
              ),
              const SizedBox(width: 10),
              Text('Draw Diagrams',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      color: mode.textColor))
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: mainColor,
              ),
              const SizedBox(width: 10),
              Text('Design App Ui',
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      color: mode.textColor))
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Icon(
                Icons.check_circle,
                color: mainColor,
              ),
              const SizedBox(width: 10),
              Text('Start Coding',
                  style: TextStyle(
                      fontSize: 15,
                      decoration: TextDecoration.lineThrough,
                      fontWeight: FontWeight.w100,
                      color: mode.textColor))
            ],
          ),
        ],
      ),
    );
  }
}
