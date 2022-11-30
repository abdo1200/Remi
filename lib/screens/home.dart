import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/widgets/habit_card.dart';
import 'package:remi/widgets/header.dart';
import 'package:remi/widgets/note_card.dart';
import 'package:remi/widgets/todo_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var mode = Provider.of<ModeProvider>(context);
    return Scaffold(
      body: Container(
        color: mode.darkMode ? dark : white,
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30),
              height: height * .47,
              decoration: BoxDecoration(
                  color: navy,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              child: Column(
                children: [
                  const Header(),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Notes',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: white),
                        ),
                        Text(
                          'See all',
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        NoteCard(
                          color: mainColor,
                          title: 'title',
                          content:
                              'this is the content of the note of the note the note',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const NoteCard(
                          color: Colors.green,
                          title: 'title',
                          content:
                              'this is the content of the note of the note the note',
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const NoteCard(
                          color: Colors.orange,
                          title: 'title',
                          content:
                              'this is the content of the note of the note the note',
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Habits',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w100,
                        color: mode.textColor),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: mode.textColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            // const HabitCard(habit: 'Learning English', percent: .50),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'To Do',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w100,
                        color: mode.textColor),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: mode.textColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 5),
            // const TodoCard()
          ],
        ),
      ),
    );
  }
}
