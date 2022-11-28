import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class HabitCard extends StatelessWidget {
  final String habit;
  final double percent;
  const HabitCard({super.key, required this.habit, required this.percent});

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
            Text(habit,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w100,
                    color: mode.textColor)),
            CircularPercentIndicator(
              radius: 25.0,
              lineWidth: 2.0,
              percent: percent,
              center: Text(
                '${percent * 100} %',
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w100,
                    color: mode.textColor),
              ),
              progressColor: mainColor,
            ),
          ],
        ),
      ),
    );
  }
}
