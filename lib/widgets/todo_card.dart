import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remi/screens/bottombar.dart';

class TodoCard extends StatefulWidget {
  final String id;
  final Map<String, bool>? map;
  final String? title;
  const TodoCard(
      {super.key, required this.map, required this.title, required this.id});

  @override
  State<TodoCard> createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title!,
                style: TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w100, color: white),
              ),
              GestureDetector(
                  onTap: (() async {
                    await mode.deleteTodo(widget.id);
                    setState(() {});
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BottomBar(
                            index: 2,
                          ),
                        ));
                  }),
                  child: Icon(Icons.delete, size: 15, color: white))
            ],
          ),
          const SizedBox(height: 15),
          ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.map!.length,
              itemBuilder: ((context, index) {
                String item = widget.map!.keys.elementAt(index);
                bool? select = widget.map![item];
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
