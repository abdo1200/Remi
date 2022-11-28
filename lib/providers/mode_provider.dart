import 'package:flutter/material.dart';
import 'package:remi/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModeProvider extends ChangeNotifier {
  bool darkMode = false;
  Color cardColor = white;
  Color textColor = navy;
  Color color = Colors.white;

  List<String>? notesColorProvider;
  List<String>? notesTitleProvider;
  List<String>? notesContentProvider;

  Future<bool> getSelected() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool('mode') == null) {
      pref.setBool('mode', false);
    }
    darkMode = pref.getBool('mode')!;
    if (darkMode) {
      color = dark;
      cardColor = grey;
      textColor = white;
    } else {
      color = white;
      cardColor = white;
      textColor = navy;
    }
    return darkMode;
  }

  changeMode(newmode) {
    darkMode = newmode;
    if (darkMode) {
      color = dark;
      cardColor = grey;
      textColor = white;
    } else {
      color = white;
      cardColor = white;
      textColor = navy;
    }
    ChangeNotifier();
  }

  getNotes() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    notesColorProvider = pref.getStringList('notesColor');
    notesTitleProvider = pref.getStringList('notesTitle');
    notesContentProvider = pref.getStringList('notesContent');
  }
}
