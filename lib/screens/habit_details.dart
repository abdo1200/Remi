import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/bottombar.dart';

class HabitDetails extends StatefulWidget {
  final String id;
  final String? habit;
  final List<bool>? days;
  const HabitDetails(
      {super.key, required this.id, required this.habit, this.days});

  @override
  State<HabitDetails> createState() => _HabitDetailsState();
}

class _HabitDetailsState extends State<HabitDetails> {
  String title = '';
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BottomBar(
                                index: 3,
                              ),
                            ));
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: (mode.darkMode) ? white : navy,
                      )),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: (() async {
                          List<String> items = [];
                          for (var item in widget.days!) {
                            items.add(item.toString());
                          }
                          await mode.editHabit(widget.id,
                              (title == '') ? widget.habit : title, items);

                          // ignore: use_build_context_synchronously
                          AnimatedSnackBar.material(
                            'Saved Successfully',
                            type: AnimatedSnackBarType.success,
                            mobileSnackBarPosition: MobileSnackBarPosition.top,
                            desktopSnackBarPosition:
                                DesktopSnackBarPosition.topCenter,
                            duration: const Duration(seconds: 1),
                          ).show(context);
                        }),
                        icon: Icon(Icons.save,
                            color: (mode.darkMode) ? white : navy),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: widget.habit),
                onChanged: (value) {
                  title = value;
                },
                style: TextStyle(color: mode.textColor),
                decoration: InputDecoration.collapsed(
                    hintText: 'Enter Habit Title',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: mode.textColor,
                    )),
              ),
              const SizedBox(height: 20),
              Text(
                "days",
                style: TextStyle(color: mode.textColor, fontSize: 20),
              ),
              const SizedBox(height: 20),
              GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemCount: widget.days!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Text(
                          "day ${index + 1}",
                          style: TextStyle(color: mode.textColor),
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                widget.days![index] = !widget.days![index];
                              });
                            },
                            icon: widget.days![index]
                                ? Icon(
                                    Icons.check_circle,
                                    color: mainColor,
                                    size: 40,
                                  )
                                : Icon(
                                    Icons.circle_outlined,
                                    color: mainColor,
                                    size: 40,
                                  ))
                      ],
                    );
                  })
            ],
          ),
        )),
      ),
    );
  }
}
