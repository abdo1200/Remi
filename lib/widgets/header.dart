import 'package:remi/main.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Dashboard',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: white),
        ),
        Text(
          'Make each day your masterpiece!',
          style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w100, color: mainColor),
        ),
      ],
    );
  }
}
