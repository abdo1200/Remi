import 'dart:math';
import 'package:flutter/material.dart';
import 'package:remi/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ModeProvider extends ChangeNotifier {
  bool darkMode = false;
  Color cardColor = white;
  Color textColor = navy;
  Color color = Colors.white;

  List<String>? notes;

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
    notes = pref.getStringList('notes');
    return notes;
  }

  Future<Map<String, String>> getTodoes() async {
    Map<String, String> todoes = {};
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? todoesId = pref.getStringList('todoes');
    for (int i = 0; i < todoesId!.length; i++) {
      todoes[todoesId[i]] = pref.getString('${todoesId[i]}title')!;
    }
    return todoes;
  }

  Future<Map<String, String>> getHabits() async {
    Map<String, String> habits = {};
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? habitsId = pref.getStringList('habits');
    for (int i = 0; i < habitsId!.length; i++) {
      habits[habitsId[i]] = pref.getString('${habitsId[i]}title')!;
    }
    return habits;
  }

  Future<Map<String, bool>> getTodoItems(String id) async {
    Map<String, bool> map = {};
    SharedPreferences pref = await SharedPreferences.getInstance();
    List? items = pref.getStringList('${id}items');
    List? selectedItems = pref.getStringList('${id}selected');
    for (int i = 0; i < items!.length; i++) {
      if (selectedItems![i].length == 5) {
        map[items[i]] = false;
      } else {
        map[items[i]] = true;
      }
    }
    return map;
  }

  Future<List<bool>> getHabitdays(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? days = pref.getStringList('${id}days');
    List<bool> daysbool = [];
    for (int i = 0; i < days!.length; i++) {
      if (days[i].length == 5) {
        daysbool.add(false);
      } else {
        daysbool.add(true);
      }
    }
    return daysbool;
  }

  Future<List<String>?> getNoteDetails(String title) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? details = pref.getStringList(title);
    return details;
  }

  final _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(Set<String> keys) {
    String id = String.fromCharCodes(Iterable.generate(
        8, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

    if (keys.contains(id)) {
      return getRandomString(keys);
    } else {
      return id;
    }
  }

  addNote(String title, String content, String selectedColor) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = getRandomString(pref.getKeys());
    List<String>? notes = pref.getStringList('notes');
    if (notes == null) {
      notes = ['note$id'];
      pref.setStringList('notes', notes);
      pref.setStringList('note$id', [title, content, selectedColor]);
    } else {
      notes.add('note$id');
      pref.setStringList('notes', notes);
      pref.setStringList('note$id', [title, content, selectedColor]);
    }
  }

  addTodo(String title, List<String> listItems, List<String> listSelect) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = getRandomString(pref.getKeys());
    if (pref.getStringList('todoes') != null) {
      List<String>? todoes = pref.getStringList('todoes');
      todoes?.add('todo$id');
      await pref.setStringList('todoes', todoes!);
      await pref.setString('todo$id' 'title', title);
      await pref.setStringList('todo$id' 'items', listItems);
      await pref.setStringList('todo$id' 'selected', listSelect);
    } else {
      List<String> todoes = [];
      todoes.add('todo$id');
      await pref.setStringList('todoes', todoes);
      await pref.setString('todo$id' 'title', title);
      await pref.setStringList('todo$id' 'items', listItems);
      await pref.setStringList('todo$id' 'selected', listSelect);
    }
  }

  addHabit(String title, int period) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String id = getRandomString(pref.getKeys());
    if (pref.getStringList('habits') != null) {
      List<String>? habits = pref.getStringList('habits');
      List<String> days = [];
      habits?.add('habit$id');
      for (int i = 0; i < period; i++) {
        days.add(false.toString());
      }
      await pref.setStringList('habits', habits!);
      await pref.setString('habit$id' 'title', title);
      await pref.setStringList('habit$id' 'days', days);
    } else {
      List<String> habits = [];
      habits.add('habit$id');
      List<String> days = [];
      for (int i = 0; i < period; i++) {
        days.add(false.toString());
      }
      await pref.setStringList('habits', habits);
      await pref.setString('habit$id' 'title', title);
      await pref.setStringList('habit$id' 'days', days);
    }
  }

  editNote(
      String id, String title, String content, String selectedColor) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setStringList(id, [title, content, selectedColor]);
  }

  deleteNote(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? notes = pref.getStringList('notes');
    notes!.remove(id);
    pref.setStringList('notes', notes);
    pref.remove(id);
  }

  editTodo(String id, String? title, List<String> listItems,
      List<String> listSelect) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('${id}title', title!);
    await pref.setStringList('${id}items', listItems);
    await pref.setStringList('${id}selected', listSelect);
    //print(pref.getKeys());
  }

  deleteTodo(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? todoes2 = pref.getStringList('todoes');
    todoes2!.remove(id);
    pref.setStringList('todoes', todoes2);
    pref.remove('${id}title');
    pref.remove('${id}items');
    pref.remove('${id}selected');
  }

  editHabit(String id, String? title, List<String> days) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('${id}title', title!);
    await pref.setStringList('${id}days', days);
  }

  deleteHabit(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? habits = pref.getStringList('habits');
    habits!.remove(id);
    pref.setStringList('habits', habits);
    pref.remove('${id}title');
    pref.remove('${id}days');
  }
}
