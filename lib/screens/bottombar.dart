import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/habits.dart';
import 'package:remi/screens/home.dart';
import 'package:remi/screens/notes.dart';
import 'package:remi/screens/setting.dart';
import 'package:remi/screens/todoes.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Widget? _child;

  @override
  void initState() {
    _child = const Home();
    super.initState();
  }

  void _handleNavigationChange(int index) {
    setState(() {
      switch (index) {
        case 0:
          _child = const Home();
          break;
        case 1:
          _child = const Notes();
          break;
        case 2:
          _child = const Todoes();
          break;
        case 3:
          _child = const Habits();
          break;
        case 4:
          _child = const Setting();
          break;
      }
      _child = AnimatedSwitcher(
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        duration: const Duration(milliseconds: 500),
        child: _child,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);
    return Scaffold(
      backgroundColor: mode.color,
      body: _child,
      bottomNavigationBar: FluidNavBar(
        style: FluidNavBarStyle(
          barBackgroundColor: mainColor,
          iconUnselectedForegroundColor: white,
          iconSelectedForegroundColor: navy,
        ),
        icons: [
          // (2)
          FluidNavBarIcon(svgPath: 'assets/img/home.svg'), // (3)
          FluidNavBarIcon(svgPath: 'assets/img/note.svg'),
          FluidNavBarIcon(svgPath: 'assets/img/todo.svg'),
          FluidNavBarIcon(svgPath: 'assets/img/tracker.svg'),
          FluidNavBarIcon(icon: Icons.settings),
        ],
        onChange: _handleNavigationChange, // (4)
      ),
    );
  }
}
