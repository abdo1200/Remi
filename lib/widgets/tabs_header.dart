import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabsHeader extends StatelessWidget {
  final Function function;
  final String title;
  final String btnText;
  const TabsHeader(
      {super.key,
      required this.function,
      required this.title,
      required this.btnText});

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: mode.textColor),
          ),
          GestureDetector(
            onTap: () {
              function();
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: navy,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                btnText,
                style: TextStyle(
                    fontSize: 13, fontWeight: FontWeight.w400, color: white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
