import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddHabit extends StatefulWidget {
  const AddHabit({super.key});

  @override
  State<AddHabit> createState() => _AddHabitState();
}

class _AddHabitState extends State<AddHabit> {
  String title = ' ';
  int period = 10;

  // List of items in our dropdown menu
  var items = [
    10,
    15,
    30,
  ];

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);
    return Scaffold(
      backgroundColor: mode.color,
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: (mode.darkMode) ? white : navy,
                      )),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: (() async {
                          mode.addHabit(title, period);
                        }),
                        child: Icon(Icons.save,
                            color: (mode.darkMode) ? white : navy),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                onChanged: (value) {
                  title = value;
                },
                style: TextStyle(color: white),
                decoration: InputDecoration.collapsed(
                    hintText: 'Enter Habit Title',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: mode.textColor,
                    )),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: mainColor, //background color of dropdown button
                    border: Border.all(
                        color: Colors.black38,
                        width: 3), //border of dropdown button
                    borderRadius: BorderRadius.circular(
                        50), //border raiuds of dropdown button
                    boxShadow: <BoxShadow>[
                      //apply shadow on Dropdown button
                      const BoxShadow(
                          color:
                              Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                          blurRadius: 5) //blur radius of shadow
                    ]),
                child: DropdownButton(
                  dropdownColor: mainColor, //dropdown background color
                  underline: Container(), //remove underline
                  isExpanded: true,
                  // Initial Value
                  value: period,
                  borderRadius: BorderRadius.circular(10),

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((int items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text('$items days'),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (int? newValue) {
                    setState(() {
                      period = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}

var items = [
  'Item 1',
  'Item 2',
  'Item 3',
  'Item 4',
  'Item 5',
];
