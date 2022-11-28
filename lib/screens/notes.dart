import 'package:provider/provider.dart';
import 'package:remi/main.dart';
import 'package:remi/providers/mode_provider.dart';
import 'package:remi/screens/add_note.dart';
import 'package:remi/widgets/note_card.dart';
import 'package:remi/widgets/tabs_header.dart';
import 'package:flutter/material.dart';

class Notes extends StatelessWidget {
  const Notes({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var mode = Provider.of<ModeProvider>(context);

    return SafeArea(
      child: Column(
        children: [
          TabsHeader(
              function: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddNote()),
                );
              },
              title: 'Notes',
              btnText: 'Add Note'),
          SizedBox(
            width: double.infinity,
            height: height * .80,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FutureBuilder<void>(
                  future: mode.getNotes(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                        itemCount: mode.notesColorProvider!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10),
                            child: NoteCard(
                                color: toColor(mode.notesColorProvider![index]),
                                title: mode.notesTitleProvider![index],
                                content: mode.notesContentProvider![index]),
                          );
                        },
                      );
                      // return Container();
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
