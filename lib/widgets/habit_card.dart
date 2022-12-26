import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:remi/screens/bottombar.dart';

class HabitCard extends StatelessWidget {
  final String id;
  final String? habit;
  final List<bool>? days;
  const HabitCard(
      {super.key, required this.habit, required this.days, required this.id});

  double percent(List<bool>? days) {
    int checked = 0;
    for (int i = 0; i < days!.length; i++) {
      if (days[i] == true) {
        checked = checked + 1;
      }
    }
    return (checked / days.length);
  }

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(habit!,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                    color: mode.textColor)),
            Row(
              children: [
                CircularPercentIndicator(
                  radius: 25.0,
                  lineWidth: 2.0,
                  percent: percent(days),
                  center: Text(
                    '${(percent(days) * 100).toInt()} %',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: mode.textColor),
                  ),
                  progressColor: mainColor,
                ),
                const SizedBox(width: 10),
                GestureDetector(
                    onTap: (() async {
                      await mode.deleteHabit(id);
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomBar(
                              index: 3,
                            ),
                          ));
                    }),
                    child: Icon(Icons.delete, size: 15, color: white))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
