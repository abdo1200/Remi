// ignore_for_file: library_private_types_in_public_api

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:remi/main.dart';
import 'package:remi/screens/habits.dart';
import 'package:remi/screens/home.dart';
import 'package:remi/screens/notes.dart';
import 'package:remi/screens/setting.dart';
import 'package:remi/screens/todoes.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomBar extends StatefulWidget {
  int index;

  BottomBar({super.key, required this.index});
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final screens = [
    const Home(),
    const Notes(),
    const Todoes(),
    const Habits(),
    const Setting()
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      const Icon(Icons.home, size: 30), // (3)
      SvgPicture.asset('assets/img/note.svg', width: 30),
      SvgPicture.asset('assets/img/todo.svg', width: 30),
      SvgPicture.asset('assets/img/tracker.svg', width: 30),
      const Icon(Icons.settings, size: 30),
    ];
    return Scaffold(
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: widget.index,
          height: 60.0,
          items: items,
          color: mainColor,
          buttonBackgroundColor: mainColor,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              widget.index = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: screens[widget.index]);
  }
}
