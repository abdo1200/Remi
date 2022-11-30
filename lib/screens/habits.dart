import 'package:provider/provider.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/add_habit.dart';
import 'package:remi/widgets/habit_card.dart';
import 'package:remi/widgets/tabs_header.dart';
import 'package:flutter/material.dart';

class Habits extends StatelessWidget {
  const Habits({super.key});

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              TabsHeader(
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const AddHabit()),
                    );
                  },
                  title: 'Habits',
                  btnText: 'Add Habit'),
              FutureBuilder<void>(
                  future: mode.getHabits(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (mode.habits.isNotEmpty) {
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: mode.habits.length,
                          itemBuilder: (context, index) {
                            String id = mode.habits.keys.elementAt(index);

                            return FutureBuilder<List<bool>>(
                                future: mode.getHabitdays(id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: HabitCard(
                                            habit: mode.habits[id],
                                            days: snapshot.data));
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                });
                          },
                        );
                      } else {
                        return const Text('No Habites yet');
                      }
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
