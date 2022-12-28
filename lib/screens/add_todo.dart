import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/bottombar.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  String title = ' ';

  List<listTile> listDynamic = [];

  add() {
    listDynamic.add(listTile());
    setState(() {});
  }

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
                                index: 2,
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
                          List<String> listTitle = [];
                          List<String> listSelect = [];

                          for (var widget in listDynamic) {
                            listTitle = listTitle + [widget.controller.text];
                          }

                          for (var widget in listDynamic) {
                            listSelect =
                                listSelect + [widget.isSelected.toString()];
                          }
                          if (title == ' ' || listTitle.isEmpty) {
                            await AnimatedSnackBar.material(
                              'Please Fill All Data',
                              type: AnimatedSnackBarType.error,
                              mobileSnackBarPosition:
                                  MobileSnackBarPosition.top,
                              desktopSnackBarPosition:
                                  DesktopSnackBarPosition.topCenter,
                              duration: const Duration(seconds: 1),
                            ).show(context);
                          } else {
                            await mode.addTodo(title, listTitle, listSelect);

                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomBar(
                                    index: 2,
                                  ),
                                ));
                          }
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
                onChanged: (value) {
                  title = value;
                },
                style: TextStyle(fontSize: 25, color: mode.textColor),
                decoration: InputDecoration.collapsed(
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 25, color: mode.textColor)),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Items',
                    style: TextStyle(fontSize: 20, color: mode.textColor),
                  ),
                  ListView.builder(
                      physics: const ScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: listDynamic.length,
                      itemBuilder: (_, index) => listDynamic[index]),
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () {
                        add();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: mainColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Text(
                          'Add Item',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}

// ignore: camel_case_types, must_be_immutable
class listTile extends StatefulWidget {
  TextEditingController controller = TextEditingController();

  bool isSelected;
  listTile({super.key, this.isSelected = false});

  @override
  State<listTile> createState() => _listTileState();
}

// ignore: camel_case_types
class _listTileState extends State<listTile> {
  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);
    return ListTile(
        title: TextField(
          controller: widget.controller,
          style: TextStyle(
            color: mode.textColor,
            decoration: widget.isSelected
                ? TextDecoration.lineThrough
                : TextDecoration.none,
          ),
          decoration: InputDecoration.collapsed(
              hintText: 'Item',
              hintStyle: TextStyle(fontSize: 20, color: mode.textColor)),
        ),
        leading: GestureDetector(
            onTap: () {
              setState(() {
                widget.isSelected = !widget.isSelected;
              });
            },
            child: widget.isSelected
                ? Icon(
                    Icons.check_circle,
                    color: mainColor,
                  )
                : Icon(Icons.circle_outlined, color: mainColor)));
  }
}
