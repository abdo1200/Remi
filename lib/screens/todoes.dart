import 'package:remi/widgets/tabs_header.dart';
import 'package:remi/widgets/todo_card.dart';
import 'package:flutter/material.dart';

class Todoes extends StatelessWidget {
  const Todoes({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              TabsHeader(
                  function: () {}, title: 'ToDo Lists', btnText: 'Add List'),
              for (int i = 0; i < 5; i++)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TodoCard(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
