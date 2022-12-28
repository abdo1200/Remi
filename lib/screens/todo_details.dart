import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/bottombar.dart';

class TodoDetails extends StatefulWidget {
  final String id;
  final String? title;
  final Map<String, bool>? map;
  const TodoDetails(
      {super.key, required this.id, required this.title, required this.map});

  @override
  State<TodoDetails> createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  String title = '';
  List items = [];
  List itemSelect = [];
  @override
  void initState() {
    items = widget.map!.keys.toList();
    itemSelect = widget.map!.values.toList();
    super.initState();
  }

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
                          List<String> selects = [];
                          List<String> newItems = [];
                          for (var item in items) {
                            newItems.add(item);
                          }
                          for (var widget in listDynamic) {
                            newItems.add(widget.controller.text);
                          }
                          for (var item in itemSelect) {
                            selects.add(item.toString());
                          }
                          for (var widget in listDynamic) {
                            selects.add(widget.isSelected.toString());
                          }

                          await mode.editTodo(
                              widget.id,
                              (title == '') ? widget.title : title,
                              newItems,
                              selects);

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
                controller: TextEditingController(text: widget.title),
                onChanged: (value) {
                  title = value;
                },
                style: TextStyle(color: mode.textColor),
                decoration: InputDecoration.collapsed(
                    hintText: 'Title',
                    hintStyle: TextStyle(fontSize: 20, color: mode.textColor)),
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
                      itemCount: widget.map!.length,
                      itemBuilder: (_, index) {
                        return ListTile(
                            title: TextField(
                              controller:
                                  TextEditingController(text: items[index]),
                              style: TextStyle(
                                color: mode.textColor,
                                decoration: itemSelect[index]
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                              onChanged: (value) {
                                items[index] = value;
                              },
                              decoration: InputDecoration.collapsed(
                                  hintText: 'Item',
                                  hintStyle: TextStyle(
                                      fontSize: 20, color: mode.textColor)),
                            ),
                            leading: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    itemSelect[index] = !itemSelect[index];
                                  });
                                },
                                child: itemSelect[index]
                                    ? Icon(
                                        Icons.check_circle,
                                        color: mainColor,
                                      )
                                    : Icon(Icons.circle_outlined,
                                        color: mainColor)));
                      }),
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

  bool isSelected = false;
  listTile({super.key});

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
