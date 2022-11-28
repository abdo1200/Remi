import 'package:remi/widgets/habit_card.dart';
import 'package:remi/widgets/tabs_header.dart';
import 'package:flutter/material.dart';

class Habits extends StatelessWidget {
  const Habits({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              TabsHeader(
                  function: () {}, title: 'Habits', btnText: 'Add Habit'),
              for (int i = 0; i < 10; i++)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: HabitCard(habit: 'Learning English', percent: .50),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
