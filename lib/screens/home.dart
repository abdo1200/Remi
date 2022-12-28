import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/add_habit.dart';
import 'package:remi/screens/add_note.dart';
import 'package:remi/screens/add_todo.dart';
import 'package:remi/screens/bottombar.dart';
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
      backgroundColor: mode.color,
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
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
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomBar(
                                          index: 1,
                                        )),
                              );
                            },
                            child: Text(
                              'See all',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: white),
                            ),
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
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/img/no.png',
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                .1),
                                        const SizedBox(height: 20),
                                        Text(
                                          'No Notes yet',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: mode.textColor),
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty
                                                    .resolveWith((states) {
                                              // If the button is pressed, return green, otherwise blue
                                              if (states.contains(
                                                  MaterialState.pressed)) {
                                                return navy;
                                              }
                                              return mainColor;
                                            }),
                                          ),
                                          onPressed: (() {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const AddNote(),
                                                ));
                                          }),
                                          child: const Text('Add Note'),
                                        )
                                      ],
                                    )
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: (mode.notes!.length < 2)
                                          ? Row(
                                              children: [
                                                FutureBuilder<List<String>?>(
                                                    future: mode.getNoteDetails(
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
                                                              Navigator
                                                                  .pushReplacement(
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
                                                                id: mode
                                                                    .notes![0],
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
                                                        mode.notes!.length - 1;
                                                    index >
                                                        mode.notes!.length - 3;
                                                    index--)
                                                  FutureBuilder<List<String>?>(
                                                      future: mode
                                                          .getNoteDetails(mode
                                                              .notes![index]),
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
                                                                Navigator
                                                                    .pushReplacement(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) => NoteDetials(
                                                                          id: mode.notes![
                                                                              index],
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
                                                                      index],
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
                                            ),
                                    );
                            } else {
                              return const CircularProgressIndicator();
                            }
                            // return Container();
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/img/no.png',
                                    height: MediaQuery.of(context).size.height *
                                        .1),
                                const SizedBox(height: 20),
                                Text(
                                  'No Notes yet',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: white),
                                ),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      // If the button is pressed, return green, otherwise blue
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return navy;
                                      }
                                      return mainColor;
                                    }),
                                  ),
                                  onPressed: (() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const AddNote(),
                                        ));
                                  }),
                                  child: const Text('Add Note'),
                                )
                              ],
                            );
                          }
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Habits',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                          color: mode.textColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomBar(
                                    index: 3,
                                  )),
                        );
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: mode.textColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              FutureBuilder<Map<String, String>>(
                  future: mode.getHabits(),
                  builder: (context, snapshot2) {
                    if (snapshot2.connectionState == ConnectionState.done) {
                      if (snapshot2.hasData) {
                        if (snapshot2.data!.isNotEmpty) {
                          String id = snapshot2.data!.keys.elementAt(0);
                          return FutureBuilder<List<bool>>(
                              future: mode.getHabitdays(id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return GestureDetector(
                                    onTap: (() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HabitDetails(
                                                      id: id,
                                                      habit:
                                                          snapshot2.data![id],
                                                      days: snapshot.data)));
                                    }),
                                    child: HabitCard(
                                        id: id,
                                        habit: snapshot2.data![id],
                                        days: snapshot.data),
                                  );
                                } else {
                                  return const CircularProgressIndicator();
                                }
                              });
                        } else {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'No Habits yet',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w200,
                                    color: mode.textColor),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) {
                                    if (states
                                        .contains(MaterialState.pressed)) {
                                      return navy;
                                    }
                                    return navy;
                                  }),
                                ),
                                onPressed: (() {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const AddHabit(),
                                      ));
                                }),
                                child: const Text('Add Habit'),
                              )
                            ],
                          );
                        }
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Habits yet',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200,
                                  color: mode.textColor),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  if (states.contains(MaterialState.pressed)) {
                                    return navy;
                                  }
                                  return navy;
                                }),
                              ),
                              onPressed: (() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddHabit(),
                                    ));
                              }),
                              child: const Text('Add Habit'),
                            )
                          ],
                        );
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Todoes',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w100,
                          color: mode.textColor),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BottomBar(
                                    index: 2,
                                  )),
                        );
                      },
                      child: Text(
                        'See all',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: mode.textColor),
                      ),
                    ),
                  ],
                ),
              ),
              SafeArea(
                child: FutureBuilder<Map<String, String>>(
                    future: mode.getTodoes(),
                    builder: (context, snapshot2) {
                      if (snapshot2.hasData) {
                        if (snapshot2.connectionState == ConnectionState.done) {
                          if (snapshot2.data!.isNotEmpty) {
                            String id = snapshot2.data!.keys.elementAt(0);
                            return FutureBuilder<Map<String, bool>>(
                                future: mode.getTodoItems(id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => TodoDetails(
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
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                });
                          } else {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No Todoes yet',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w200,
                                      color: mode.textColor),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      // If the button is pressed, return green, otherwise blue
                                      if (states
                                          .contains(MaterialState.pressed)) {
                                        return navy;
                                      }
                                      return navy;
                                    }),
                                  ),
                                  onPressed: (() {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const AddTodo(),
                                        ));
                                  }),
                                  child: const Text('Add Todo'),
                                )
                              ],
                            );
                          }
                          // return Container();
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      } else {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'No Todoes yet',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w200,
                                  color: mode.textColor),
                            ),
                            const SizedBox(width: 10),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.resolveWith((states) {
                                  // If the button is pressed, return green, otherwise blue
                                  if (states.contains(MaterialState.pressed)) {
                                    return navy;
                                  }
                                  return navy;
                                }),
                              ),
                              onPressed: (() {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const AddTodo(),
                                    ));
                              }),
                              child: const Text('Add Todo'),
                            )
                          ],
                        );
                      }
                    }),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ),
      ),
    );
  }
}
