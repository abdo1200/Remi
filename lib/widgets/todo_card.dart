import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoCard extends StatelessWidget {
  final Map<String, bool>? map;
  final String? title;
  const TodoCard({super.key, required this.map, required this.title});

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
              Text(title!,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w100,
                      color: mode.textColor)),
            ],
          ),
          const SizedBox(height: 15),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: map!.length,
              itemBuilder: ((context, index) {
                String item = map!.keys.elementAt(index);
                bool? select = map![item];
                return Row(
                  children: [
                    select!
                        ? Icon(
                            Icons.check_circle,
                            color: mainColor,
                          )
                        : Icon(Icons.circle_outlined, color: mainColor),
                    const SizedBox(width: 10),
                    Text(item,
                        style: TextStyle(
                            decoration: select
                                ? TextDecoration.lineThrough
                                : TextDecoration.none,
                            fontSize: 15,
                            fontWeight: FontWeight.w100,
                            color: mode.textColor))
                  ],
                );
              })),
        ],
      ),
    );
  }
}
