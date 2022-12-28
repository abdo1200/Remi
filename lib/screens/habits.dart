import 'package:provider/provider.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/add_habit.dart';
import 'package:remi/screens/habit_details.dart';
import 'package:remi/widgets/habit_card.dart';
import 'package:remi/widgets/tabs_header.dart';
import 'package:flutter/material.dart';

class Habits extends StatelessWidget {
  const Habits({super.key});

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);
    return Scaffold(
        backgroundColor: mode.color,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  TabsHeader(
                      function: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddHabit()),
                        );
                      },
                      title: 'Habits',
                      btnText: 'Add Habit'),
                  FutureBuilder<Map<String, String>>(
                      future: mode.getHabits(),
                      builder: (context, snapshot2) {
                        if (snapshot2.connectionState == ConnectionState.done) {
                          if (snapshot2.hasData) {
                            if (snapshot2.data!.isNotEmpty) {
                              return ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemCount: snapshot2.data!.length,
                                itemBuilder: (context, index) {
                                  String id =
                                      snapshot2.data!.keys.elementAt(index);

                                  return FutureBuilder<List<bool>>(
                                      future: mode.getHabitdays(id),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          return Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: GestureDetector(
                                                onTap: (() {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              HabitDetails(
                                                                  id: id,
                                                                  habit: snapshot2
                                                                          .data![
                                                                      id],
                                                                  days: snapshot
                                                                      .data)));
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
                                },
                              );
                            } else {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 80),
                                  Image.asset('assets/img/no.png',
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .3),
                                  const SizedBox(height: 20),
                                  Text(
                                    'No Habits yet',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: mode.textColor),
                                  ),
                                ],
                              );
                            }
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 80),
                                Image.asset('assets/img/no.png',
                                    height: MediaQuery.of(context).size.height *
                                        .3),
                                const SizedBox(height: 20),
                                Text(
                                  'No Habits yet',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: mode.textColor),
                                ),
                              ],
                            );
                          }
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
