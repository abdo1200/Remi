import 'package:provider/provider.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/add_todo.dart';
import 'package:remi/screens/todo_details.dart';
import 'package:remi/widgets/tabs_header.dart';
import 'package:remi/widgets/todo_card.dart';
import 'package:flutter/material.dart';

class Todoes extends StatelessWidget {
  const Todoes({super.key});

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<ModeProvider>(context);
    return Scaffold(
        backgroundColor: mode.color,
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  TabsHeader(
                      function: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddTodo()),
                        );
                      },
                      title: 'ToDo Lists',
                      btnText: 'Add List'),
                  FutureBuilder<Map<String, String>>(
                      future: mode.getTodoes(),
                      builder: (context, snapshot2) {
                        if (snapshot2.connectionState == ConnectionState.done) {
                          if (snapshot2.data!.isNotEmpty) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot2.data!.length,
                              itemBuilder: (context, index) {
                                String id =
                                    snapshot2.data!.keys.elementAt(index);

                                return FutureBuilder<Map<String, bool>>(
                                    future: mode.getTodoItems(id),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.done) {
                                        return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          TodoDetails(
                                                        id: id,
                                                        title:
                                                            snapshot2.data![id],
                                                        map: snapshot.data,
                                                      ),
                                                    ));
                                              },
                                              child: TodoCard(
                                                id: id,
                                                title: snapshot2.data![id],
                                                map: snapshot.data,
                                              ),
                                            ));
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    });
                              },
                            );
                          } else {
                            return const Text('No Todoes yet');
                          }
                          // return Container();
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
