import 'package:provider/provider.dart';
import 'package:remi/main.dart';
import 'package:flutter/material.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/bottombar.dart';

class NoteCard extends StatelessWidget {
  final String id;
  final Color color;
  final String title;
  final String content;

  const NoteCard({
    super.key,
    required this.color,
    required this.title,
    required this.content,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var mode = Provider.of<ModeProvider>(context);
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
                GestureDetector(
                    onTap: (() async {
                      await mode.deleteNote(id);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomBar(
                              index: 1,
                            ),
                          ));
                    }),
                    child: Icon(Icons.delete, size: 15, color: white))
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
