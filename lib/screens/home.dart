import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/habit_details.dart';
import 'package:remi/screens/note_details.dart';
import 'package:remi/screens/todo_details.dart';
import 'package:remi/widgets/habit_card.dart';
import 'package:remi/widgets/header.dart';
import 'package:remi/widgets/note_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remi/widgets/todo_card.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var mode = Provider.of<ModeProvider>(context);
    return Scaffold(
      body: Container(
        color: mode.color,
        width: double.infinity,
        child: SingleChildScrollView(
          child: SafeArea(
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
                        height: 10,
                      ),
                      FutureBuilder<void>(
                          future: mode.getNotes(),
                          builder: (context, snapshot) {
                            if (mode.notes != null) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return (mode.notes!.isEmpty)
                                    ? const Text('No Notes yet')
                                    : SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: (mode.notes!.length < 2)
                                            ? Row(
                                                children: [
                                                  FutureBuilder<List<String>?>(
                                                      future:
                                                          mode.getNoteDetails(
                                                              mode.notes![0]),
                                                      builder:
                                                          (context, snapshot) {
                                                        if (snapshot
                                                                .connectionState ==
                                                            ConnectionState
                                                                .done) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child:
                                                                GestureDetector(
                                                              onTap: (() {
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => NoteDetials(
                                                                          id: mode.notes![
                                                                              0],
                                                                          color: toColor(snapshot.data![
                                                                              2]),
                                                                          title: snapshot.data![
                                                                              0],
                                                                          content:
                                                                              snapshot.data![1])),
                                                                );
                                                              }),
                                                              child: NoteCard(
                                                                  id: mode.notes![
                                                                      0],
                                                                  color: toColor(
                                                                      snapshot.data![
                                                                          2]),
                                                                  title: snapshot
                                                                      .data![0],
                                                                  content: snapshot
                                                                      .data![1]),
                                                            ),
                                                          );
                                                        } else {
                                                          return const CircularProgressIndicator();
                                                        }
                                                      })
                                                ],
                                              )
                                            : Row(
                                                children: [
                                                  for (int index =
                                                          mode.notes!.length -
                                                              1;
                                                      index >
                                                          mode.notes!.length -
                                                              3;
                                                      index--)
                                                    FutureBuilder<
                                                            List<String>?>(
                                                        future: mode
                                                            .getNoteDetails(mode
                                                                .notes![index]),
                                                        builder: (context,
                                                            snapshot) {
                                                          if (snapshot
                                                                  .connectionState ==
                                                              ConnectionState
                                                                  .done) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child:
                                                                  GestureDetector(
                                                                onTap: (() {
                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (context) => NoteDetials(
                                                                            id: mode.notes![
                                                                                index],
                                                                            color:
                                                                                toColor(snapshot.data![2]),
                                                                            title: snapshot.data![0],
                                                                            content: snapshot.data![1])),
                                                                  );
                                                                }),
                                                                child: NoteCard(
                                                                    id: mode.notes![
                                                                        index],
                                                                    color: toColor(
                                                                        snapshot.data![
                                                                            2]),
                                                                    title: snapshot
                                                                            .data![
                                                                        0],
                                                                    content:
                                                                        snapshot
                                                                            .data![1]),
                                                              ),
                                                            );
                                                          } else {
                                                            return const CircularProgressIndicator();
                                                          }
                                                        })
                                                ],
                                              ),
                                      );
                              } else {
                                return const Text('No Notes yet');
                              }
                              // return Container();
                            } else {
                              return const Text('No Notes yet');
                            }
                          }),
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
                FutureBuilder<Map<String, String>>(
                    future: mode.getHabits(),
                    builder: (context, snapshot2) {
                      if (snapshot2.connectionState == ConnectionState.done) {
                        if (snapshot2.data!.isNotEmpty) {
                          String id = snapshot2.data!.keys.elementAt(0);
                          return FutureBuilder<List<bool>>(
                              future: mode.getHabitdays(id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: GestureDetector(
                                        onTap: (() {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      HabitDetails(
                                                          id: id,
                                                          habit: snapshot2
                                                              .data![id],
                                                          days:
                                                              snapshot.data)));
                                        }),
                                        child: HabitCard(
                                            id: id,
                                            habit: snapshot2.data![id],
                                            days: snapshot.data),
                                      ));
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              });
                        } else {
                          return const Text('No Habites yet');
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
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
                FutureBuilder<Map<String, String>>(
                    future: mode.getTodoes(),
                    builder: (context, snapshot2) {
                      if (snapshot2.connectionState == ConnectionState.done) {
                        if (snapshot2.data!.isNotEmpty) {
                          String id = snapshot2.data!.keys.elementAt(0);
                          return FutureBuilder<Map<String, bool>>(
                              future: mode.getTodoItems(id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TodoDetails(
                                                  id: id,
                                                  title: snapshot2.data![id],
                                                  map: snapshot.data,
                                                ),
                                              ));
                                        },
                                        child: TodoCard(
                                          id: id,
                                          title: snapshot2.data![id],
                                          map: snapshot.data,
                                        ),
                                      ));
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              });
                        } else {
                          return const Text('No Todoes yet');
                        }
                        // return Container();
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
                const SizedBox(height: 10)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
